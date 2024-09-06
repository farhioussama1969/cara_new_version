import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/tag_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/windows/credit_card_form_window_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/windows/progress_status_window_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/components/my_cars_window_component.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/components/payment_window_component.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/components/washing_types_window_component.dart';
import 'package:solvodev_mobile_structure/app/modules/home/views/components/working_hours_window_component.dart';

import '../controllers/home_controller.dart';
import 'components/confirm_window_component.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10.r),
        child: Container(
          height: 100.r,
          width: 100.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000.r),
            child: FloatingActionButton(
              backgroundColor: MainColors.primaryColor,
              child: GetBuilder<HomeController>(
                  id: GetBuildersIdsConstants.homeFloatingButton,
                  builder: (logic) {
                    return !logic.checkingServiceAvailabilityLoading
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                IconsAssetsConstants.caraIcon,
                                width: 38.r,
                                height: 38.r,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text(
                                StringsAssetsConstants.orderWash,
                                style: TextStyles.smallBodyTextStyle(context)
                                    .copyWith(
                                  color: MainColors.whiteColor,
                                ),
                              )
                            ],
                          )
                        : LoadingComponent(
                            color: MainColors.whiteColor,
                          );
                  }),
              onPressed: () {
                controller.createOrderSteps();
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Stack(
        children: [
          Container(
            color: MainColors.backgroundColor(context),
            child: GoogleMap(
              initialCameraPosition:
                  controller.initialGoogleMapsCameraPosition ??
                      const CameraPosition(
                        target: LatLng(25.851747, 43.522231),
                        zoom: 15,
                      ),
              onMapCreated: (googleMapsController) =>
                  controller.updateGoogleMapsController(googleMapsController),
              mapToolbarEnabled: false,
              zoomControlsEnabled: false,
              rotateGesturesEnabled: false,
              myLocationEnabled: false,
              myLocationButtonEnabled: false,
              onCameraMove: (cameraPosition) {
                controller.changeIsMapCameraMoving(true);
                controller.currentLatitude = cameraPosition.target.latitude;
                controller.currentLongitude = cameraPosition.target.longitude;
              },
              onCameraIdle: () {
                controller.changeIsMapCameraMoving(false);
              },
            ),
          ),
          IgnorePointer(
            child: Center(
              child: GetBuilder<HomeController>(
                id: GetBuildersIdsConstants.homeMapMarker,
                builder: (logic) {
                  return AnimatedScale(
                    duration: const Duration(milliseconds: 300),
                    scale: logic.isMapCameraMoving ? 2.5 : 1.5,
                    curve: Curves.easeInOutCubic,
                    child: Image.asset(
                      ImagesAssetsConstants.locationPinImage,
                      width: 75.r,
                      height: 75.r,
                    ),
                  );
                },
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                child: GetBuilder<HomeController>(
                    id: GetBuildersIdsConstants.homeFloatingButton,
                    builder: (logic) {
                      return logic.checkServiceAvailabilityResponse
                                  ?.availability ==
                              false
                          ? SafeArea(
                              child: Padding(
                                padding: EdgeInsets.only(top: 10.h),
                                child: TagComponent(
                                  title: StringsAssetsConstants
                                      .serviceNotAvailable,
                                  backgroundColor:
                                      MainColors.errorColor(context),
                                  textStyle:
                                      TextStyles.largeBodyTextStyle(context)
                                          .copyWith(
                                    color: MainColors.whiteColor,
                                  ),
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  height: 50.h,
                                )
                                    .animate(delay: (100).ms)
                                    .fadeIn(duration: 900.ms, delay: 300.ms)
                                    .move(
                                      begin: const Offset(0, -200),
                                      duration: 500.ms,
                                    ),
                              ),
                            )
                          : const SizedBox.shrink();
                    }),
              ),
              Column(
                children: [
                  SafeArea(
                    child: Padding(
                      padding: EdgeInsets.all(10.r),
                      child: Row(
                        children: [
                          GetBuilder<HomeController>(
                              id: GetBuildersIdsConstants
                                  .pickCurrentLocationButton,
                              builder: (logic) {
                                return IconButtonComponent(
                                  iconLink: IconsAssetsConstants.locationIcon,
                                  onTap: () => logic
                                      .enableAndGetStartingPositionFromGeoLocator(),
                                  iconColor: MainColors.textColor(context),
                                  child: logic.getCurrentPositionLoading
                                      ? const LoadingComponent()
                                      : null,
                                );
                              }),
                        ],
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      BottomAppBar(
                        color: MainColors.backgroundColor(context),
                        elevation: 0,
                        shape: const CircularNotchedRectangle(),
                        notchMargin: 5.r,
                        height: 40.h,
                        child: Container(),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.w, vertical: 15.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.getWashingTypes();
                                showWashingTypesWindow();
                              },
                              child: Row(
                                children: [
                                  GetBuilder<HomeController>(
                                      id: GetBuildersIdsConstants
                                          .homeWashingTypesButton,
                                      builder: (logic) {
                                        return SvgPicture.asset(
                                          logic.selectedWashingTypeId == null
                                              ? IconsAssetsConstants.carWashIcon
                                              : IconsAssetsConstants
                                                  .checked3Icon,
                                          width: 25.r,
                                          height: 25.r,
                                        );
                                      }),
                                  SizedBox(width: 8.w),
                                  Text(
                                    StringsAssetsConstants.washingType,
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                controller.getWorkingHours();
                                showWorkingHoursWindow();

                                // controller.changeMyCarsList(null,
                                //     refresh: true);
                                // controller.getMyCars();
                                // showMyCarsWindow();
                              },
                              child: Row(
                                children: [
                                  Text(
                                    StringsAssetsConstants.setDate,
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  GetBuilder<HomeController>(
                                      id: GetBuildersIdsConstants
                                          .homeSetDateButton,
                                      builder: (logic) {
                                        return SvgPicture.asset(
                                          logic.selectedTime == null
                                              ? IconsAssetsConstants
                                                  .calendarIcon
                                              : IconsAssetsConstants
                                                  .checked3Icon,
                                          width: 25.r,
                                          height: 25.r,
                                        );
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  void showWashingTypesWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<HomeController>(
        autoRemove: false,
        id: GetBuildersIdsConstants.homeWashingTypes,
        builder: (logic) {
          return WashingTypesWindowComponent(
            loading: logic.getWashingTypesLoading,
            washingTypes: logic.washingTypes,
            selectedWashingTypeId: logic.selectedWashingTypeId,
            onWashingTypeSelected: (washingType) =>
                logic.changeSelectedWashingTypeId(washingType.id),
            onConfirm: () {
              Get.back();
              controller.createOrderSteps();
            },
          );
        },
      ),
    );
  }

  void showWorkingHoursWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<HomeController>(
        id: GetBuildersIdsConstants.homeSetDateWindow,
        builder: (logic) {
          return WorkingHoursWindowComponent(
            loading: logic.getWorkingHoursLoading,
            daysList: logic.daysList,
            timesList: logic.timesList,
            selectedDay: logic.selectedDay ?? '',
            selectedTime: logic.selectedTime,
            onDaySelected: (day) => logic.changeSelectedDay(day),
            onTimeSelected: (time) => logic.changeSelectedTime(time.value),
            onConfirm: () {
              Get.back();
              controller.createOrderSteps();
            },
          );
        },
      ),
    );
  }

  void showMyCarsWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<HomeController>(
        id: GetBuildersIdsConstants.homeMyCarsWindow,
        builder: (logic) {
          return MyCarsWindowComponent(
            scrollController: logic.myCarsListScrollController,
            loading: logic.getMyCarsListLoading,
            carsList: logic.myCarsList?.data ?? [],
            onCarSelected: (car) {
              logic.changeSelectedCarId(car.id);
            },
            selectedCardId: logic.selectedCarId,
            onConfirm: () {
              Get.back();
              controller.createOrderSteps();
            },
          );
        },
      ),
    );
  }

  void showConfirmWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: ConfirmWindowComponent(
        selectedDate: controller.selectedDay,
        selectedTime: controller.selectedTime,
        selectedCar: controller.myCarsList?.data
            ?.where((e) => e.id == controller.selectedCarId)
            .first,
        selectedWashingType: controller.washingTypes
            ?.where((e) => e.id == controller.selectedWashingTypeId)
            .first,
        onConfirm: () {
          Get.back();
          controller.getFreeWashingConfig();
          controller.getWalletAmount();
          controller.getSubscriptionsList();
          controller.changeCoupon(null);
          showPaymentWindow();
        },
        onChangeCar: () {
          Get.back();
          controller.getMyCars();
          showMyCarsWindow();
        },
        onChangeDate: () {
          Get.back();
          controller.getWorkingHours();
          showWorkingHoursWindow();
        },
        onChangeWashingType: () {
          Get.back();
          controller.getWashingTypes();
          showWashingTypesWindow();
        },
      ),
    );
  }

  void showPaymentWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<HomeController>(
          id: GetBuildersIdsConstants.homePaymentWindow,
          builder: (logic) {
            return PaymentWindowComponent(
              selectedPaymentMethod: logic.selectedPaymentMethod,
              onPaymentMethodSelected: (paymentMethod) =>
                  logic.changeSelectedPaymentMethod(paymentMethod),
              getWalletAmountLoading: logic.getWalletAmountLoading,
              walletAmount: logic.walletAmount,
              couponController: logic.couponController,
              onCouponApply: () =>
                  logic.applyCoupon(logic.couponController.text),
              coupon: logic.coupon,
              freeWashesPaymentLoading: logic.freePaymentLoading,
              getMySubscriptionsLoading: logic.getSubscriptionsListLoading,
              subscriptionsList: logic.subscriptionsList,
              applePaymentLoading: logic.applePaymentLoading,
              onApplePayment: () {},
              subscriptionPaymentLoading: logic.subscriptionPaymentLoading,
              walletPaymentLoading: logic.walletPaymentLoading,
              getFreeWashesConfig: logic.getFreeWashingConfigLoading,
              freeWashingConfig: logic.freeWashingConfig,
              selectedSubscription: logic.selectedSubscriptionId,
              onSubscriptionSelected: (id) =>
                  logic.changeSelectedSubscriptionId(id),
              washingType: logic.selectedWashingTypeId != null
                  ? logic.washingTypes
                      .where((e) => e.id == logic.selectedWashingTypeId)
                      .first
                  : null,
              couponFormKey: logic.couponFormKey,
              applyCouponLoading: logic.couponApplyLoading,
              onCouponDeleted: () {
                logic.changeCoupon(null);
                logic.couponController.clear();
              },
              onConfirm: () {
                if (logic.selectedPaymentMethod == 1) {
                  logic.walletPayment();
                } else if (logic.selectedPaymentMethod == 3) {
                  logic.subscriptionPayment();
                } else if (logic.selectedPaymentMethod == 4) {
                  logic.freePayment(false);
                } else if (logic.coupon?.actualTotal == 0) {
                  logic.freePayment(true);
                } else if (logic.selectedPaymentMethod == 2) {
                  Get.back();
                  showCreditCardFormWindow();
                }
              },
            );
          }),
    );
  }

  void showCreateOrderStatusWindow(bool status) {
    BottomSheetComponent.show(Get.context!,
        dismissible: false,
        body: ProgressStatusWindowComponent(
          success: status,
          text: status
              ? StringsAssetsConstants.successOrderDescription
              : StringsAssetsConstants.failedOrderDescription,
          onDone: () {
            if (status) {
              Get.back();
              Get.back();
              controller.resetData();
            } else {
              Get.back();
              Get.back();
              controller.changeSelectedTime(null);
              controller.changeSelectedDay(null);
            }
          },
        ));
  }

  void showCreditCardFormWindow() {
    BottomSheetComponent.show(
      Get.context!,
      dismissible: false,
      body: GetBuilder<HomeController>(
        id: GetBuildersIdsConstants.homeCreditCardWindow,
        builder: (logic) {
          return CreditCardFormWindowComponent(
            loading: logic.creditCardPaymentLoading,
            onConfirm: () {},
            totalPrice: logic.coupon?.actualTotal ?? 0,
          );
        },
      ),
    );
  }
}
