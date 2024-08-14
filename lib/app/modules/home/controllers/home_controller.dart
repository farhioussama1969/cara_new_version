import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/geolocator_location_service.dart';

class HomeController extends GetxController {
  bool checkingServiceAvailabilityLoading = false;
  void changeCheckingServiceAvailabilityLoading(bool value) {
    checkingServiceAvailabilityLoading = value;
    update([GetBuildersIdsConstants.homeFloatingButton]);
  }

  //maps
  GoogleMapController? googleMapsController;

  void updateGoogleMapsController(GoogleMapController mapController) {
    googleMapsController = mapController;
    if (Get.arguments != null) {
      if (Get.arguments['latitude'] != null &&
          Get.arguments['longitude'] != null) {
        print('ok');
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
      {bool? withoutGetPlace}) async {
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
      if (withoutGetPlace == null || !withoutGetPlace) {
      } else {}
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
      //  await getAddressFromCoordinates(currentLatitude!, currentLongitude!);
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

  Future<void> enableAndGetStartingPositionFromGeolocator() async {
    Position? newPosition = await GeolocatorLocationService.getCurrentLocation(
      onLoading: () {
        changeGetCurrentPositionLoading(true);
      },
      onFinal: () {
        changeGetCurrentPositionLoading(false);
      },
    );
    if (newPosition != null) {
      changeStartingPosition(newPosition);
    }
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
