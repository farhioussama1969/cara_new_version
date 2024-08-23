import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/geolocator_location_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/check_service_availability_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/free_washing_config_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/user_subscription_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/car_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/order_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/subscription_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/wallet_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/home_view.dart';

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
    changeWorkingHours([]);
    daysList.clear();
    timesList.clear();
    changeSelectedTime(null);
    changeSelectedCarId(null);
    changeSelectedWashingTypeId(null);
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
        isPositionChanged = false;
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

  bool isPositionChanged = true;

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
      isPositionChanged = true;
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
    update([
      GetBuildersIdsConstants.homeSetDateWindow,
      GetBuildersIdsConstants.homeSetDateButton
    ]);
  }

  //my cars

  final ScrollController myCarsListScrollController = ScrollController();

  bool getMyCarsListLoading = false;
  void changeGetMyCarsListLoading(bool newGetMyCarsListLoading) {
    getMyCarsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.homeMyCarsWindow]);
  }

  PaginationModel<CarModel>? myCarsList;
  void changeMyCarsList(PaginationModel<CarModel>? newData, {bool? refresh}) {
    if (refresh == true) {
      myCarsList = null;
    } else {
      if (myCarsList?.data?.isNotEmpty == true) {
        myCarsList?.data?.addAll(newData?.data ?? []);
        myCarsList?.meta = newData?.meta;
      } else {
        myCarsList = newData;
      }
    }
    update([GetBuildersIdsConstants.homeMyCarsWindow]);
  }

  int myCarsCurrentPage = 1;
  void getMyCars() {
    CarProvider()
        .getCarsList(
      page: myCarsCurrentPage,
      onLoading: () => changeGetMyCarsListLoading(true),
      onFinal: () => changeGetMyCarsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeMyCarsList(value);
        }
      },
    );
  }

  void recentLocationsScrollEvent() {
    myCarsListScrollController.addListener(() {
      double maxScroll = myCarsListScrollController.position.maxScrollExtent;
      if (myCarsListScrollController.offset > maxScroll * 0.8) {
        if (!getMyCarsListLoading) {
          if (myCarsCurrentPage < (myCarsList?.meta?.lastPage ?? 0)) {
            myCarsCurrentPage++;
            getMyCars();
          }
        }
      }
    });
  }

  int? selectedCarId;
  void changeSelectedCarId(int? newSelectedCarId) {
    selectedCarId = newSelectedCarId;
    update([GetBuildersIdsConstants.homeMyCarsWindow]);
  }

  Future<void> createOrderSteps() async {
    if (isPositionChanged) {
      await checkServiceAvailability();
    }
    if (checkServiceAvailabilityResponse?.availability == true) {
      if (selectedDay == null || selectedTime == null) {
        getWorkingHours();
        const HomeView().showWorkingHoursWindow();
        return;
      }
      if (selectedWashingTypeId == null) {
        getWashingTypes();
        const HomeView().showWashingTypesWindow();
        return;
      }
      if (selectedCarId == null) {
        getMyCars();
        const HomeView().showMyCarsWindow();
        return;
      }
      const HomeView().showConfirmWindow();
    }
  }

  //payment config

  int selectedPaymentMethod = 0;
  void changeSelectedPaymentMethod(int newSelectedPaymentMethod) {
    selectedPaymentMethod = newSelectedPaymentMethod;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  bool getWalletAmountLoading = false;
  void changeGetWalletAmountLoading(bool value) {
    getWalletAmountLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  double walletAmount = 0;
  void changeWallet(double? walletAmount) {
    this.walletAmount = walletAmount ?? 0;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void getWalletAmount() {
    WalletProvider()
        .getWalletAmount(
      onLoading: () => changeGetWalletAmountLoading(true),
      onFinal: () => changeGetWalletAmountLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeWallet(value);
      }
    });
  }

  List<UserSubscriptionModel> subscriptionsList = [];
  void changeSubscriptionsList(
      List<UserSubscriptionModel> newSubscriptionsList) {
    subscriptionsList = newSubscriptionsList;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  bool getSubscriptionsListLoading = false;
  void changeGetSubscriptionsListLoading(bool value) {
    getSubscriptionsListLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void getSubscriptionsList() {
    SubscriptionProvider()
        .getMySubscriptionsList(
      branchId: checkServiceAvailabilityResponse?.branch?.id,
      onLoading: () => changeGetSubscriptionsListLoading(true),
      onFinal: () => changeGetSubscriptionsListLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeSubscriptionsList(value);
      }
    });
  }

  FreeWashingConfigModel? freeWashingConfig;

  void changeFreeWashingConfig(FreeWashingConfigModel? value) {
    freeWashingConfig = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  bool getFreeWashingConfigLoading = false;
  void changeGetFreeWashingConfigLoading(bool value) {
    getFreeWashingConfigLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void getFreeWashingConfig() {
    ConfigProvider()
        .freeWashingConfig(
      branchId: checkServiceAvailabilityResponse?.branch?.id,
      onLoading: () => changeGetFreeWashingConfigLoading(true),
      onFinal: () => changeGetFreeWashingConfigLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeFreeWashingConfig(value);
      }
    });
  }

  //apple payment
  bool applePaymentLoading = false;
  void changeApplePaymentLoading(bool value) {
    applePaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void applePayment() {}

  //wallet payment
  bool walletPaymentLoading = false;
  void changeWalletPaymentLoading(bool value) {
    walletPaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void walletPayment() {}

  //subscription payment
  bool subscriptionPaymentLoading = false;
  void changeSubscriptionPaymentLoading(bool value) {
    subscriptionPaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void subscriptionPayment() {}

  //coupon
  final TextEditingController couponController = TextEditingController();

  bool couponApplyLoading = false;
  void changeCouponApplyLoading(bool value) {
    couponApplyLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  CouponModel? coupon;
  void changeCoupon(CouponModel? value) {
    coupon = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void applyCoupon(String couponCode) {
    if (couponApplyLoading) return;
    OrderProvider()
        .applyCoupon(
      branchId: checkServiceAvailabilityResponse?.branch?.id,
      couponCode: couponCode,
      washingTypeId: selectedWashingTypeId,
      onLoading: () => changeCouponApplyLoading(true),
      onFinal: () => changeCouponApplyLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeCoupon(value);
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.couponNotValid);
      }
    });
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    recentLocationsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
