import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/geolocator_location_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/check_service_availability_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/order_provider.dart';

class HomeController extends GetxController {
  bool checkingServiceAvailabilityLoading = false;
  void changeCheckingServiceAvailabilityLoading(bool value) {
    checkingServiceAvailabilityLoading = value;
    update([GetBuildersIdsConstants.homeFloatingButton]);
  }

  CheckServiceAvailabilityModel? checkServiceAvailabilityResponse;

  void changeCheckServiceAvailabilityResponse(
      CheckServiceAvailabilityModel? checkServiceAvailabilityResponse) {
    this.checkServiceAvailabilityResponse = checkServiceAvailabilityResponse;
    update([GetBuildersIdsConstants.homeFloatingButton]);
  }

  Future<void> checkServiceAvailability() async {
    changeCheckServiceAvailabilityResponse(null);
    if (checkingServiceAvailabilityLoading) return;
    await ConfigProvider()
        .checkServiceAvailability(
      lat: currentLatitude,
      lng: currentLongitude,
      onLoading: () => changeCheckingServiceAvailabilityLoading(true),
      onFinal: () => changeCheckingServiceAvailabilityLoading(false),
    )
        .then(
      (value) {
        if (value?.availability == true) {
          changeCheckServiceAvailabilityResponse(value);
        } else {
          changeCheckServiceAvailabilityResponse(value);
          ToastComponent.showErrorToast(Get.context!,
              text: StringsAssetsConstants.serviceNotAvailable);
        }
      },
    );
  }

  //maps
  GoogleMapController? googleMapsController;

  void updateGoogleMapsController(GoogleMapController mapController) {
    googleMapsController = mapController;
    if (Get.arguments != null) {
      if (Get.arguments['latitude'] != null &&
          Get.arguments['longitude'] != null) {
        changeStartingPosition(
          Position(
            latitude: Get.arguments['latitude'],
            longitude: Get.arguments['longitude'],
            timestamp: DateTime.now(),
            headingAccuracy: 0,
            altitudeAccuracy: 0,
            accuracy: 0,
            altitude: 0,
            heading: 0,
            speed: 0,
            speedAccuracy: 0,
            floor: 0,
          ),
        );
      }
    }
  }

  CameraPosition? initialGoogleMapsCameraPosition;

  void changeInitialGoogleMapsCameraPosition(CameraPosition newCameraPosition) {
    initialGoogleMapsCameraPosition = newCameraPosition;
  }

  Position? selectedPosition;

  Future<void> changeStartingPosition(Position? newPosition,
      {bool? checkTheServiceAvailability}) async {
    selectedPosition = newPosition;
    if (newPosition != null) {
      changeInitialGoogleMapsCameraPosition(CameraPosition(
        target:
            LatLng(selectedPosition!.latitude!, selectedPosition!.longitude!),
        zoom: 14,
      ));
      googleMapsController?.animateCamera(CameraUpdate.newLatLngZoom(
          LatLng(selectedPosition!.latitude!, selectedPosition!.longitude!),
          14));
      if (checkTheServiceAvailability == true) {
        checkServiceAvailability();
      } else {
        print(
            'latitude: ${selectedPosition!.latitude} | longitude: ${selectedPosition!.longitude}');
      }
    }
  }

  double? currentLatitude;
  double? currentLongitude;

  bool isMapCameraMoving = false;

  Future<void> changeIsMapCameraMoving(bool newIsMapCameraMoving) async {
    if (isMapCameraMoving == newIsMapCameraMoving) return;
    isMapCameraMoving = newIsMapCameraMoving;

    if (isMapCameraMoving) {
      currentLatitude = null;
      currentLongitude = null;
    } else if (!isMapCameraMoving) {
      //checkServiceAvailability();
    }
    update([
      GetBuildersIdsConstants.homeMapMarker,
    ]);
  }

  bool getCurrentPositionLoading = false;

  void changeGetCurrentPositionLoading(bool newGetCurrentPositionLoading) {
    getCurrentPositionLoading = newGetCurrentPositionLoading;
    update([GetBuildersIdsConstants.pickCurrentLocationButton]);
  }

  Future<void> enableAndGetStartingPositionFromGeoLocator() async {
    Position? newPosition = await GeolocatorLocationService.getCurrentLocation(
      onLoading: () {
        changeGetCurrentPositionLoading(true);
      },
      onFinal: () {
        changeGetCurrentPositionLoading(false);
      },
    );
    if (newPosition != null) {
      changeStartingPosition(newPosition, checkTheServiceAvailability: true);
    }
  }

  //washing types
  List<WashingTypeModel> washingTypes = [];
  void changeWashingTypes(List<WashingTypeModel> newWashingTypes) {
    washingTypes = newWashingTypes;
    update([GetBuildersIdsConstants.homeWashingTypes]);
  }

  bool getWashingTypesLoading = false;
  void changeGetWashingTypesLoading(bool newGetWashingTypesLoading) {
    getWashingTypesLoading = newGetWashingTypesLoading;
    update([GetBuildersIdsConstants.homeWashingTypes]);
  }

  void getWashingTypes() {
    changeWashingTypes([]);
    OrderProvider()
        .getWashingTypes(
      onLoading: () => changeGetWashingTypesLoading(true),
      onFinal: () => changeGetWashingTypesLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeWashingTypes(value);
      }
    });
  }

  int? selectedWashingTypeId;
  void changeSelectedWashingTypeId(int? newSelectedWashingTypeId) {
    selectedWashingTypeId = newSelectedWashingTypeId;
    update([
      GetBuildersIdsConstants.homeWashingTypes,
      GetBuildersIdsConstants.homeWashingTypesButton,
    ]);
  }

  //working hours
  bool getWorkingHoursLoading = false;
  void changeGetWorkingHoursLoading(bool newGetWorkingHoursLoading) {
    getWorkingHoursLoading = newGetWorkingHoursLoading;
    update([GetBuildersIdsConstants.homeSetDateWindow]);
  }

  List<WorkingTimesModel> workingHours = [];

  List<String> daysList = [];
  List<TimeModel> timesList = [];

  void changeTimesList(String selectedDay) {
    workingHours.forEach((element) {
      if (element.day == selectedDay) {
        timesList.add(element.times!);
      }
    });
    update([GetBuildersIdsConstants.homeSetDateWindow]);
  }

  void changeWorkingHours(List<WorkingTimesModel> newWorkingHours) {
    workingHours = newWorkingHours;
    if (workingHours.isNotEmpty) {
      workingHours.forEach((element) {
        if (!daysList.contains(element.day!)) {
          daysList.add(element.day!);
        }
      });
      changeTimesList(daysList[0]);
    }

    update([GetBuildersIdsConstants.homeSetDateWindow]);
  }

  void getWorkingHours() {
    changeWorkingHours([]);
    OrderProvider()
        .getOrderHours(
      branchId: checkServiceAvailabilityResponse?.branch?.id,
      onLoading: () => changeGetWorkingHoursLoading(true),
      onFinal: () => changeGetWorkingHoursLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeWorkingHours(value);
      }
    });
  }

  String? selectedDay;
  void changeSelectedDay(String? newSelectedDay) {
    selectedDay = newSelectedDay;
    changeSelectedTime(null);
    changeTimesList(selectedDay!);
    update([GetBuildersIdsConstants.homeSetDateWindow]);
  }

  String? selectedTime;
  void changeSelectedTime(String? newSelectedTime) {
    selectedTime = newSelectedTime;
    update([GetBuildersIdsConstants.homeSetDateWindow]);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
