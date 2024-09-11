import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/gift_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/old_gift_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/windows/progress_status_window_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_model.dart';
import 'package:solvodev_mobile_structure/app/modules/send_gifts/views/components/share_gift_window_component.dart';

import '../../../core/components/animations/loading_component.dart';
import '../../../core/components/others/empty_component.dart';
import '../../../core/constants/get_builders_ids_constants.dart';
import '../controllers/send_gifts_controller.dart';
import 'components/payment_window_component.dart';

class SendGiftsView extends GetView<SendGiftsController> {
  const SendGiftsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        actionWidget: Text(
          StringsAssetsConstants.sendGifts,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(
            const Duration(milliseconds: 1500),
            () => controller.giftsCurrentTabIndex == 1
                ? controller.refreshGifts()
                : controller.refreshOldGifts()),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<SendGiftsController>(
              id: GetBuildersIdsConstants.sendGiftsList,
              builder: (logic) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        SizedBox(
                          height: 50.h,
                          child: GetBuilder<SendGiftsController>(
                              id: GetBuildersIdsConstants.sendGiftsTopBar,
                              builder: (logic) {
                                return CustomSlidingSegmentedControl<int>(
                                  initialValue: 1,
                                  fixedWidth: 0.35.sw,
                                  //height: 40.h,
                                  children: {
                                    1: Text(StringsAssetsConstants.buyGifts,
                                        style: TextStyles.largeBodyTextStyle(
                                                context)
                                            .copyWith(
                                          color: logic.giftsCurrentTabIndex == 1
                                              ? MainColors.whiteColor
                                              : MainColors.textColor(context),
                                        )),
                                    2: Text(
                                      StringsAssetsConstants.oldGifts,
                                      style:
                                          TextStyles.largeBodyTextStyle(context)
                                              .copyWith(
                                        color: logic.giftsCurrentTabIndex == 2
                                            ? MainColors.whiteColor
                                            : MainColors.textColor(context),
                                      ),
                                    ),
                                  },
                                  decoration: BoxDecoration(
                                    color: MainColors.inputColor(context),
                                    borderRadius: BorderRadius.circular(1000.r),
                                  ),
                                  innerPadding: EdgeInsets.zero,
                                  thumbDecoration: BoxDecoration(
                                    color: MainColors.primaryColor,
                                    borderRadius: BorderRadius.circular(1000.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: MainColors.shadowColor(context)!,
                                        blurRadius: 4.0,
                                        spreadRadius: 1.0,
                                        offset: const Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  duration: const Duration(milliseconds: 200),
                                  curve: Curves.linear,
                                  onValueChanged: (v) =>
                                      logic.changeGiftsCurrentPage(v),
                                );
                              }),
                        )
                            .animate(delay: (150).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .shimmer(
                                blendMode: BlendMode.srcOver,
                                color: MainColors.backgroundColor(context)
                                    ?.withOpacity(0.3))
                            .move(
                              begin: const Offset(0, -100),
                            ),
                        Expanded(
                          child: logic.giftsCurrentTabIndex == 1
                              ? SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  controller: logic.giftsListScrollController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        child: ((logic.giftsList?.data
                                                        ?.isEmpty ==
                                                    true) &&
                                                !logic.getGiftsListLoading)
                                            ? Column(
                                                children: [
                                                  EmptyComponent(
                                                    text: StringsAssetsConstants
                                                        .emptyDataText,
                                                  ),
                                                  SizedBox(height: 20.h),
                                                ],
                                              )
                                            : (logic.getGiftsListLoading &&
                                                    (logic.giftsList?.data ??
                                                                [])
                                                            .isEmpty ==
                                                        true)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                                top: 50.h,
                                                                bottom: 50.h),
                                                    child: const Center(
                                                      child: LoadingComponent(),
                                                    ),
                                                  )
                                                : Stack(
                                                    children: [
                                                      ListView.separated(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                          start: 20.w,
                                                          end: 20.w,
                                                          top: 5.h,
                                                          bottom: 30.h,
                                                        ),
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () {
                                                              controller
                                                                  .getWalletAmount();
                                                              showPaymentWindow(
                                                                  logic.giftsList
                                                                          ?.data?[
                                                                      index]);
                                                            },
                                                            child:
                                                                GiftCardComponent(
                                                              gift: logic
                                                                      .giftsList
                                                                      ?.data?[
                                                                  index],
                                                            ),
                                                          )
                                                              .animate(
                                                                  delay: (index *
                                                                          50)
                                                                      .ms)
                                                              .fadeIn(
                                                                  duration:
                                                                      900.ms,
                                                                  delay: 300.ms)
                                                              .move(
                                                                begin:
                                                                    const Offset(
                                                                        200, 0),
                                                                duration:
                                                                    500.ms,
                                                              );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                              height: 10.h);
                                                        },
                                                        itemCount: logic
                                                                .giftsList
                                                                ?.data
                                                                ?.length ??
                                                            0,
                                                      ),
                                                    ],
                                                  ),
                                      ),
                                    ],
                                  ),
                                )
                              : SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(
                                      parent: AlwaysScrollableScrollPhysics()),
                                  controller:
                                      logic.oldGiftsListScrollController,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      SizedBox(height: 10.h),
                                      SizedBox(
                                        child: ((logic.oldGiftsList?.data
                                                        ?.isEmpty ==
                                                    true) &&
                                                !logic.getOldGiftsListLoading)
                                            ? Column(
                                                children: [
                                                  EmptyComponent(
                                                    text: StringsAssetsConstants
                                                        .emptyDataText,
                                                  ),
                                                  SizedBox(height: 20.h),
                                                ],
                                              )
                                            : (logic.getOldGiftsListLoading &&
                                                    (logic.oldGiftsList?.data ??
                                                                [])
                                                            .isEmpty ==
                                                        true)
                                                ? Padding(
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .only(
                                                                top: 50.h,
                                                                bottom: 50.h),
                                                    child: const Center(
                                                      child: LoadingComponent(),
                                                    ),
                                                  )
                                                : Stack(
                                                    children: [
                                                      ListView.separated(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .only(
                                                          start: 20.w,
                                                          end: 20.w,
                                                          top: 5.h,
                                                          bottom: 30.h,
                                                        ),
                                                        physics:
                                                            const NeverScrollableScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemBuilder:
                                                            (context, index) {
                                                          return GestureDetector(
                                                            onTap: () {},
                                                            child:
                                                                OldGiftCardComponent(
                                                              giftCoupon: logic
                                                                  .oldGiftsList
                                                                  ?.data?[index],
                                                              onShare: () =>
                                                                  shareGiftWindow(logic
                                                                      .oldGiftsList
                                                                      ?.data?[index]),
                                                            ),
                                                          )
                                                              .animate(
                                                                  delay: (index *
                                                                          50)
                                                                      .ms)
                                                              .fadeIn(
                                                                  duration:
                                                                      900.ms,
                                                                  delay: 300.ms)
                                                              .move(
                                                                begin:
                                                                    const Offset(
                                                                        200, 0),
                                                                duration:
                                                                    500.ms,
                                                              );
                                                        },
                                                        separatorBuilder:
                                                            (context, index) {
                                                          return SizedBox(
                                                              height: 10.h);
                                                        },
                                                        itemCount: logic
                                                                .oldGiftsList
                                                                ?.data
                                                                ?.length ??
                                                            0,
                                                      ),
                                                    ],
                                                  ),
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ],
                    ),
                    if (logic.getOldGiftsListLoading &&
                        logic.oldGiftsList?.data?.isNotEmpty == true)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(bottom: 20.h),
                            child: const Center(
                              child: LoadingComponent(),
                            ),
                          ),
                        ],
                      ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void shareGiftWindow(GiftCouponModel? giftCoupon) {
    BottomSheetComponent.show(
      Get.context!,
      body: ShareGiftWindowComponent(
        noteController: controller.noteController,
        onShare: () {
          controller.shareTextInvitationCode(
              '${StringsAssetsConstants.shareGiftCardText} ${giftCoupon?.code}',
              controller.noteController.text,
              '${giftCoupon?.numberWashes ?? 0}',
              '${giftCoupon?.code}',
              ImagesAssetsConstants.giftCardImage);
        },
        onView: () {
          controller.openGiftFile(
              '${StringsAssetsConstants.shareGiftCardText} ${giftCoupon?.code}',
              controller.noteController.text,
              '${giftCoupon?.numberWashes ?? 0}',
              '${giftCoupon?.code}',
              ImagesAssetsConstants.giftCardImage);
        },
        gift: giftCoupon,
      ),
    );
  }

  void showPaymentWindow(GiftModel? gift) {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<SendGiftsController>(
          id: GetBuildersIdsConstants.sendGiftPaymentWindow,
          builder: (logic) {
            return PaymentWindowComponent(
              gift: gift,
              selectedPaymentMethod: logic.selectedPaymentMethod,
              onPaymentMethodSelected: (paymentMethod) =>
                  logic.changeSelectedPaymentMethod(paymentMethod),
              getWalletAmountLoading: logic.getWalletAmountLoading,
              walletAmount: logic.walletAmount,
              applePaymentLoading: logic.applePaymentLoading,
              onApplePayment: () {},
              walletPaymentLoading: logic.walletPaymentLoading,
              onConfirm: () {
                if (logic.selectedPaymentMethod == 1) {
                  logic.walletPayment(gift?.id);
                } else if (logic.selectedPaymentMethod == 2) {
                  Get.back();
                  //showCreditCardFormWindow();
                }
              },
            );
          }),
    );
  }

  void showCreateGiftStatusWindow(bool status, GiftCouponModel? giftCoupon) {
    BottomSheetComponent.show(Get.context!,
        dismissible: false,
        body: ProgressStatusWindowComponent(
          success: status,
          text: status
              ? StringsAssetsConstants.successGiftOrderDescription
              : StringsAssetsConstants.failedGiftOrderDescription,
          onDone: () {
            if (status) {
              Get.back();
              Get.back();
              shareGiftWindow(giftCoupon);
            } else {
              Get.back();
              Get.back();
            }
          },
        ));
  }
}
