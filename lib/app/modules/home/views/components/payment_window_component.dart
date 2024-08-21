import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animator_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class PaymentWindowComponent extends StatelessWidget {
  const PaymentWindowComponent(
      {super.key,
      this.selectedPaymentMethod,
      required this.onPaymentMethodSelected});

  final int? selectedPaymentMethod;
  final Function(int) onPaymentMethodSelected;

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
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () => onPaymentMethodSelected(1),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                              child: Text(
                                StringsAssetsConstants.paymentByWallet,
                                style: TextStyles.largeBodyTextStyle(context)
                                    .copyWith(
                                  fontFamily: FontsFamilyAssetsConstants.bold,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        if (selectedPaymentMethod == 1)
                          Positioned.fill(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.only(end: 0.w),
                                  child: AnimatorComponent(
                                    time: const Duration(microseconds: 100),
                                    child: SvgPicture.asset(
                                      IconsAssetsConstants.checkedIcon,
                                      width: 22.r,
                                      height: 22.r,
                                      color: MainColors.primaryColor,
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
                SizedBox(height: 30.h),
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
