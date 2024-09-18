import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_config/flutter_config.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/google_maps_styles_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/geolocator_location_service.dart';
import 'package:solvodev_mobile_structure/app/core/services/moyasar_payment_service.dart';
import 'package:solvodev_mobile_structure/app/core/utils/theme_util.dart';
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
import 'package:solvodev_mobile_structure/app/modules/gifts/controllers/gifts_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/home_view.dart';
import 'package:solvodev_mobile_structure/app/modules/my_account/controllers/my_account_controller.dart';

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
    daysList = [];
    timesList = [];
    changeSelectedTime(null);
    changeSelectedCarId(null);
    changeSelectedWashingTypeId(null);
    Get.find<MyAccountController>().getWhatsAppNumber();
    Get.find<GiftsController>().getFreeWashingConfig();
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
    if (ThemeUtil.isDarkMode) {
      String _mapStyleString = '';
      rootBundle
          .loadString(GoogleMapsStylesAssetsConstants.darkModeStyle)
          .then((string) {
        _mapStyleString = string;
        googleMapsController?.setMapStyle(_mapStyleString);
      });
    }
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
      currentLongitude = newPosition.longitude;
      currentLatitude = newPosition.latitude;
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
      print('position: $newPosition');

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
    timesList.clear();
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
    daysList.clear();
    timesList.clear();
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
    if (selectedDay != null) {
      changeTimesList(selectedDay!);
    }
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

  void myCarsScrollEvent() {
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

  int? selectedPaymentMethod;
  void changeSelectedPaymentMethod(int? newSelectedPaymentMethod) {
    selectedPaymentMethod = newSelectedPaymentMethod;
    if (selectedPaymentMethod != 3) {
      changeSelectedSubscriptionId(null);
    }
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  int? selectedSubscriptionId;
  void changeSelectedSubscriptionId(int? newSelectedSubscriptionId) {
    selectedSubscriptionId = newSelectedSubscriptionId;
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
      print('value: $value');
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

  void applePayment() {
    MoyasarPaymentService.applePayPayment(
      coupon: coupon,
      orderDescription: '',
      price: washingTypes
              .where((e) => e.id == selectedWashingTypeId)
              .first
              .price ??
          0,
      publishableKey:
          checkServiceAvailabilityResponse?.branch?.moyasarPublishableApiKey ??
              FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
      merchantId: checkServiceAvailabilityResponse?.branch?.moyasarMerchantId ??
          FlutterConfig.get('MOYASAR_PAYMENT_MERCHANET_ID'),
      onLoading: () => changeApplePaymentLoading(true),
      onFinal: () => changeApplePaymentLoading(false),
      onError: () {},
    ).then((paymentRes) {
      if (paymentRes != null) {
        OrderProvider()
            .createNewOrder(
          lat: currentLatitude,
          lng: currentLongitude,
          washingTypeId: selectedWashingTypeId,
          carId: selectedCarId,
          date: selectedDay!,
          time: selectedTime!,
          paymentMethod: "Apple pay",
          couponId: coupon?.couponId,
          price: coupon?.actualTotal ?? 0,
          paymentId: paymentRes.id,
          onLoading: () => changeApplePaymentLoading(true),
          onFinal: () => changeApplePaymentLoading(false),
        )
            .then((value) {
          if (value != null) {
            const HomeView().showCreateOrderStatusWindow(true);
          } else {
            const HomeView().showCreateOrderStatusWindow(false);
          }
        });
      }
    });
  }

  //wallet payment
  bool walletPaymentLoading = false;
  void changeWalletPaymentLoading(bool value) {
    walletPaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void walletPayment() {
    OrderProvider()
        .createNewOrder(
      lat: currentLatitude,
      lng: currentLongitude,
      washingTypeId: selectedWashingTypeId,
      carId: selectedCarId,
      date: selectedDay!,
      time: selectedTime!,
      paymentMethod: "Wallet",
      couponId: coupon?.couponId,
      price: coupon?.actualTotal ?? 0,
      onLoading: () => changeWalletPaymentLoading(true),
      onFinal: () => changeWalletPaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        const HomeView().showCreateOrderStatusWindow(true);
      } else {
        const HomeView().showCreateOrderStatusWindow(false);
      }
    });
  }

  //gift order payment
  bool freePaymentLoading = false;
  void changeFreePaymentLoading(bool value) {
    freePaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void freePayment(bool gift) {
    OrderProvider()
        .createNewOrder(
      lat: currentLatitude,
      lng: currentLongitude,
      washingTypeId: selectedWashingTypeId,
      carId: selectedCarId,
      date: selectedDay!,
      time: selectedTime!,
      paymentMethod: gift ? "Gift" : "Free",
      couponId: coupon?.couponId,
      price: coupon?.actualTotal ?? 0,
      onLoading: () => changeFreePaymentLoading(true),
      onFinal: () => changeFreePaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        const HomeView().showCreateOrderStatusWindow(true);
      } else {
        const HomeView().showCreateOrderStatusWindow(false);
      }
    });
  }

  //subscription payment
  bool subscriptionPaymentLoading = false;
  void changeSubscriptionPaymentLoading(bool value) {
    subscriptionPaymentLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void subscriptionPayment() {
    OrderProvider()
        .createNewOrder(
      lat: currentLatitude,
      lng: currentLongitude,
      washingTypeId: selectedWashingTypeId,
      carId: selectedCarId,
      date: selectedDay!,
      time: selectedTime!,
      paymentMethod: "Subscription",
      couponId: coupon?.couponId,
      price: coupon?.actualTotal ?? 0,
      subscriptionId: selectedSubscriptionId,
      onLoading: () => changeSubscriptionPaymentLoading(true),
      onFinal: () => changeSubscriptionPaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        const HomeView().showCreateOrderStatusWindow(true);
      } else {
        const HomeView().showCreateOrderStatusWindow(false);
      }
    });
  }

  //coupon
  final GlobalKey<FormState> couponFormKey = GlobalKey<FormState>();
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
    if (!couponFormKey.currentState!.validate()) return;
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
        changeCoupon(null);
      }
    });
  }

  //credit card payment
  bool creditCardPaymentLoading = false;
  void changeCreditCardPaymentLoading(bool value) {
    creditCardPaymentLoading = value;
    update([GetBuildersIdsConstants.homeCreditCardWindow]);
  }

  void creditCardPayment(
      String number, String expiredDate, String cvv, String? holderName) {
    if (creditCardPaymentLoading) return;
    OrderProvider()
        .createNewOrder(
      lat: currentLatitude,
      lng: currentLongitude,
      washingTypeId: selectedWashingTypeId,
      carId: selectedCarId,
      date: selectedDay ?? '',
      time: selectedTime ?? '',
      paymentMethod: 'Credit card',
      couponId: coupon?.couponId,
      price: coupon?.actualTotal ?? 0,
      onLoading: () => changeCreditCardPaymentLoading(true),
      onFinal: () => changeCreditCardPaymentLoading(false),
    )
        .then((value) {
      if (value != null) {
        MoyasarPaymentService.creditCardPayment(
          cardHolderName: holderName ?? '',
          cardNumber: number,
          expiryDate: expiredDate,
          cvvCode: cvv,
          orderDescription: 'description',
          coupon: coupon,
          price: coupon?.actualTotal ??
              (washingTypes
                      .where((e) => e.id == selectedWashingTypeId)
                      .first
                      .price ??
                  0),
          publishableKey: checkServiceAvailabilityResponse
                  ?.branch?.moyasarPublishableApiKey ??
              FlutterConfig.get('MOYASAR_PAYMENT_API_KEY'),
          callBackUrl: '',
          onLoading: () => changeCreditCardPaymentLoading(true),
          onFinal: () => changeCreditCardPaymentLoading(false),
          onError: () {
            ToastComponent.showErrorToast(Get.context!,
                text: StringsAssetsConstants.paymentError);
          },
        ).then((paymentRes) {
          if (paymentRes != null) {
            const HomeView()
                .showCreditCardPaymentWebView(paymentRes.transactionUrl ?? '');
          }
        });
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.createOrderError);
      }
    });
  }

  //clear and reset all data
  void resetData() {
    changeSelectedCarId(null);
    changeSelectedDay(null);
    changeSelectedTime(null);
    changeSelectedPaymentMethod(null);
    changeSelectedSubscriptionId(null);
    changeSelectedWashingTypeId(null);
    changeCoupon(null);
    changeWorkingHours([]);
    daysList.clear();
    timesList.clear();
    enableAndGetStartingPositionFromGeoLocator();
  }

  @override
  void onInit() {
    enableAndGetStartingPositionFromGeoLocator();
    super.onInit();
  }

  @override
  void onReady() {
    myCarsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
