import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/subscription_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/windows/progress_status_window_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';

import '../controllers/subscriptions_controller.dart';
import 'components/payment_window_component.dart';

class SubscriptionsView extends GetView<SubscriptionsController> {
  const SubscriptionsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        actionWidget: Text(
          StringsAssetsConstants.subscriptions,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async =>
            Future.delayed(const Duration(milliseconds: 1500), () {
          controller.changeSubscriptions([]);
          controller.getSubscriptions();
        }),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<SubscriptionsController>(
              id: GetBuildersIdsConstants.subscriptionsList,
              builder: (logic) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: ((logic.subscriptions.isEmpty == true) &&
                                    !logic.getSubscriptionsLoading)
                                ? Column(
                                    children: [
                                      EmptyComponent(
                                        text: StringsAssetsConstants.emptyCars,
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  )
                                : (logic.getSubscriptionsLoading &&
                                        (logic.subscriptions ?? []).isEmpty ==
                                            true)
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 50.h, bottom: 50.h),
                                        child: const Center(
                                          child: LoadingComponent(),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          ListView.separated(
                                            padding: EdgeInsetsDirectional.only(
                                              start: 20.w,
                                              end: 20.w,
                                              top: 5.h,
                                              bottom: 30.h,
                                            ),
                                            physics:
                                                const NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            itemBuilder: (context, index) {
                                              return GestureDetector(
                                                onTap: () {
                                                  controller.getWalletAmount();
                                                  showPaymentWindow(logic
                                                      .subscriptions[index]);
                                                },
                                                child:
                                                    SubscriptionCardComponent(
                                                  subscription: logic
                                                      .subscriptions[index],
                                                ),
                                              )
                                                  .animate(
                                                      delay: (index * 50).ms)
                                                  .fadeIn(
                                                      duration: 900.ms,
                                                      delay: 300.ms)
                                                  .move(
                                                    begin: const Offset(200, 0),
                                                    duration: 500.ms,
                                                  );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 10.h);
                                            },
                                            itemCount:
                                                logic.subscriptions.length ?? 0,
                                          ),
                                        ],
                                      ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }

  void showPaymentWindow(SubscriptionPlanModel? subscription) {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<SubscriptionsController>(
          id: GetBuildersIdsConstants.subscriptionsPaymentWindow,
          builder: (logic) {
            return PaymentWindowComponent(
              subscription: subscription,
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
                  logic.walletPayment(subscription?.id);
                } else if (logic.selectedPaymentMethod == 2) {
                  Get.back();
                  //showCreditCardFormWindow();
                }
              },
            );
          }),
    );
  }

  void showCreateGiftStatusWindow(bool status) {
    BottomSheetComponent.show(Get.context!,
        dismissible: false,
        body: ProgressStatusWindowComponent(
          success: status,
          text: status
              ? StringsAssetsConstants.successSubscriptionOrderDescription
              : StringsAssetsConstants.failedSubscriptionOrderDescription,
          onDone: () {
            if (status) {
              Get.back();
              Get.back();
            } else {
              Get.back();
              Get.back();
            }
          },
        ));
  }
}
