import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animator_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/my_subscription_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/free_washing_config_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/user_subscription_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';

class PaymentWindowComponent extends StatelessWidget {
  const PaymentWindowComponent(
      {super.key,
      this.selectedPaymentMethod,
      required this.onPaymentMethodSelected,
      required this.getWalletAmountLoading,
      required this.walletAmount,
      required this.getMySubscriptionsLoading,
      required this.subscriptionsList,
      this.coupon,
      required this.couponController,
      required this.onCouponApply,
      required this.onApplePayment,
      required this.applePaymentLoading,
      required this.walletPaymentLoading,
      required this.subscriptionPaymentLoading,
      required this.freeWashesPaymentLoading,
      required this.onConfirm,
      required this.getFreeWashesConfig,
      this.freeWashingConfig,
      this.selectedSubscription,
      required this.onSubscriptionSelected,
      this.washingType});

  final int? selectedPaymentMethod;
  final Function(int) onPaymentMethodSelected;
  final bool getWalletAmountLoading;
  final double walletAmount;
  final bool getFreeWashesConfig;
  final FreeWashingConfigModel? freeWashingConfig;
  final bool getMySubscriptionsLoading;
  final List<UserSubscriptionModel> subscriptionsList;
  final CouponModel? coupon;
  final TextEditingController couponController;
  final Function onCouponApply;
  final Function onApplePayment;
  final bool applePaymentLoading;
  final bool walletPaymentLoading;
  final bool subscriptionPaymentLoading;
  final bool freeWashesPaymentLoading;
  final Function onConfirm;
  final int? selectedSubscription;
  final Function(int?) onSubscriptionSelected;
  final WashingTypeModel? washingType;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    StringsAssetsConstants.paymentMethod,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                (getMySubscriptionsLoading ||
                        getWalletAmountLoading ||
                        getFreeWashesConfig)
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 50.h, bottom: 50.h),
                            child: const Center(
                              child: LoadingComponent(),
                            ),
                          ),
                        ],
                      )
                    : Column(
                        children: [
                          SizedBox(height: 30.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${StringsAssetsConstants.totalPrice}:',
                                    style: TextStyles.mediumLabelTextStyle(
                                        context),
                                  ),
                                ),
                                if (coupon?.couponDiscount != null)
                                  SizedBox(width: 10.w),
                                Text(
                                  '${(washingType?.price ?? 0).toStringAsFixed(0)} ${StringsAssetsConstants.currency}',
                                  style:
                                      TextStyles.mediumLabelTextStyle(context)
                                          .copyWith(
                                    decoration: (coupon?.couponDiscount != null)
                                        ? TextDecoration.lineThrough
                                        : null,
                                    color: (coupon?.couponDiscount == null)
                                        ? MainColors.primaryColor
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 30.h),
                          if (walletAmount > 0 && coupon?.actualTotal != 0)
                            GestureDetector(
                              onTap: () => onPaymentMethodSelected(1),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: MainColors.shadowColor(context)!,
                                      blurRadius: 10.r,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: selectedPaymentMethod == 1
                                        ? MainColors.primaryColor
                                        : MainColors.transparentColor,
                                    width: 2.r,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: MainColors.backgroundColor(context),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          IconsAssetsConstants.walletIcon,
                                          width: 22.r,
                                          height: 22.r,
                                          color: MainColors.primaryColor,
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: RichText(
                                            text: TextSpan(
                                              text:
                                                  '${StringsAssetsConstants.paymentByWallet} ',
                                              style:
                                                  TextStyles.largeBodyTextStyle(
                                                          context)
                                                      .copyWith(
                                                fontFamily:
                                                    FontsFamilyAssetsConstants
                                                        .bold,
                                              ),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      ' (${walletAmount.toStringAsFixed(0)} ${StringsAssetsConstants.currency})',
                                                  style: TextStyles
                                                          .largeBodyTextStyle(
                                                              context)
                                                      .copyWith(
                                                    color:
                                                        MainColors.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (selectedPaymentMethod == 1)
                                      Positioned.fill(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 0.w),
                                              child: AnimatorComponent(
                                                time: const Duration(
                                                    microseconds: 100),
                                                child: SvgPicture.asset(
                                                  IconsAssetsConstants
                                                      .checkedIcon,
                                                  width: 22.r,
                                                  height: 22.r,
                                                  color:
                                                      MainColors.primaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          if (walletAmount > 0 && coupon?.actualTotal != 0)
                            SizedBox(height: 15.h),
                          if (coupon?.actualTotal != 0)
                            GestureDetector(
                              onTap: () => onPaymentMethodSelected(2),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: MainColors.shadowColor(context)!,
                                      blurRadius: 10.r,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: selectedPaymentMethod == 2
                                        ? MainColors.primaryColor
                                        : MainColors.transparentColor,
                                    width: 2.r,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: MainColors.backgroundColor(context),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          IconsAssetsConstants.creditCardIcon,
                                          width: 22.r,
                                          height: 22.r,
                                          color: MainColors.primaryColor,
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Text(
                                            StringsAssetsConstants
                                                .paymentByCreditCard,
                                            style:
                                                TextStyles.largeBodyTextStyle(
                                                        context)
                                                    .copyWith(
                                              fontFamily:
                                                  FontsFamilyAssetsConstants
                                                      .bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (selectedPaymentMethod == 2)
                                      Positioned.fill(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      end: 0.w),
                                              child: AnimatorComponent(
                                                time: const Duration(
                                                    microseconds: 100),
                                                child: SvgPicture.asset(
                                                  IconsAssetsConstants
                                                      .checkedIcon,
                                                  width: 22.r,
                                                  height: 22.r,
                                                  color:
                                                      MainColors.primaryColor,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          if (subscriptionsList.isNotEmpty)
                            SizedBox(height: 15.h),
                          if (subscriptionsList.isNotEmpty)
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    StringsAssetsConstants
                                        .orByUsingYourSubscription,
                                    style:
                                        TextStyles.mediumBodyTextStyle(context)
                                            .copyWith(
                                      color: selectedSubscription != null
                                          ? MainColors.primaryColor
                                          : MainColors.textColor(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          if (subscriptionsList.isNotEmpty)
                            Container(
                              margin: EdgeInsetsDirectional.only(top: 10.h),
                              height: 90.h,
                              child: PageView.builder(
                                physics: const BouncingScrollPhysics(),
                                itemCount: subscriptionsList.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      onPaymentMethodSelected(3);
                                      onSubscriptionSelected(
                                          subscriptionsList[index].id);
                                    },
                                    child: MySubscriptionCardComponent(
                                      subscription: subscriptionsList[index],
                                      index: index + 1,
                                      isSelected: subscriptionsList[index].id ==
                                          selectedSubscription,
                                    ),
                                  );
                                },
                              ),
                            ),
                          if (subscriptionsList.isNotEmpty)
                            SizedBox(height: 15.h),
                          if ((freeWashingConfig?.freeOrder ?? 0) > 0)
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    StringsAssetsConstants
                                        .orByUsingYourFreeWashes,
                                    style:
                                        TextStyles.mediumBodyTextStyle(context)
                                            .copyWith(
                                      color: selectedPaymentMethod == 4
                                          ? MainColors.primaryColor
                                          : MainColors.textColor(context),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          if ((freeWashingConfig?.freeOrder ?? 0) > 0)
                            SizedBox(height: 15.h),
                          if ((freeWashingConfig?.freeOrder ?? 0) > 0)
                            GestureDetector(
                              onTap: () => onPaymentMethodSelected(4),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20.w, vertical: 20.h),
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: MainColors.shadowColor(context)!,
                                      blurRadius: 10.r,
                                      offset: const Offset(0, 0),
                                    ),
                                  ],
                                  border: Border.all(
                                    color: selectedPaymentMethod == 4
                                        ? MainColors.primaryColor
                                        : MainColors.transparentColor,
                                    width: 2.r,
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: MainColors.backgroundColor(context),
                                ),
                                child: Stack(
                                  children: [
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          IconsAssetsConstants.giftEnabledIcon,
                                          width: 26.r,
                                          height: 26.r,
                                          color: MainColors.primaryColor,
                                        ),
                                        SizedBox(width: 10.w),
                                        Expanded(
                                          child: Text(
                                            StringsAssetsConstants
                                                .giftsOfFreeWashes,
                                            style:
                                                TextStyles.largeBodyTextStyle(
                                                        context)
                                                    .copyWith(
                                              fontFamily:
                                                  FontsFamilyAssetsConstants
                                                      .bold,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text:
                                                '${freeWashingConfig?.freeOrder} ',
                                            style:
                                                TextStyles.largeBodyTextStyle(
                                                        context)
                                                    .copyWith(
                                              color: MainColors.primaryColor,
                                              fontFamily:
                                                  FontsFamilyAssetsConstants
                                                      .bold,
                                            ),
                                            children: [
                                              TextSpan(
                                                text: StringsAssetsConstants
                                                    .washes,
                                                style: TextStyles
                                                        .mediumBodyTextStyle(
                                                            context)
                                                    .copyWith(),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          if (Platform.isIOS) SizedBox(height: 15.h),
                          if (Platform.isIOS)
                            Row(
                              children: [
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                  child: Text(
                                    StringsAssetsConstants.orPaymentDirectlyBy,
                                    style:
                                        TextStyles.mediumBodyTextStyle(context),
                                  ),
                                ),
                                Expanded(
                                  child: Divider(
                                    color: MainColors.textColor(context)!
                                        .withOpacity(0.2),
                                  ),
                                ),
                              ],
                            ),
                          if (Platform.isIOS) SizedBox(height: 15.h),
                          if (Platform.isIOS)
                            PrimaryButtonComponent(
                              onTap: () {},
                              text: StringsAssetsConstants.payWithApplePay,
                              iconPath: IconsAssetsConstants.appleIcon,
                              iconColor: MainColors.backgroundColor(context),
                              backgroundColor: MainColors.textColor(context),
                            ),
                          SizedBox(height: 25.h),
                          if (selectedPaymentMethod != null)
                            PrimaryButtonComponent(
                              onTap: () => onConfirm(),
                              text: StringsAssetsConstants.confirm,
                              width: 0.7.sw,
                            )
                                .animate(delay: (150).ms)
                                .fadeIn(duration: 900.ms, delay: 300.ms)
                                .move(
                                  begin: const Offset(0, 200),
                                  duration: 500.ms,
                                ),
                          SizedBox(height: 30.h),
                        ],
                      ),
              ],
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(15.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButtonComponent(
                onTap: () => Get.back(),
                iconLink: IconsAssetsConstants.closeIcon,
                buttonWidth: 23.r,
                buttonHeight: 23.r,
                iconWidth: 15.r,
                iconHeight: 15.r,
                backgroundColor:
                    MainColors.disableColor(context)?.withOpacity(0.5),
                iconColor: MainColors.whiteColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
