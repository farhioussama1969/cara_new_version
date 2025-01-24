import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/otp_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/text/animated_type_text_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/get_started/controllers/get_started_controller.dart';

class OtpVerificationWindowComponent extends StatelessWidget {
  const OtpVerificationWindowComponent(
      {super.key,
      required this.otpController,
      required this.loading,
      required this.onConfirm});

  final TextEditingController otpController;
  final bool loading;
  final Function onConfirm;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            decoration: BoxDecoration(
              color: MainColors.backgroundColor(context),
              borderRadius:
                  BorderRadiusDirectional.vertical(top: Radius.circular(30.r)),
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.h),
                  Center(
                    child: Text(
                      StringsAssetsConstants.phoneNumberVerification,
                      style: TextStyles.mediumLabelTextStyle(context),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Center(
                    child: AnimatedTypeTextComponent(
                      text: StringsAssetsConstants
                          .phoneNumberVerificationDescription,
                      textStyle:
                          TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: MainColors.textColor(context)!.withOpacity(0.6),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  OtpInputComponent(
                    controller: otpController,
                    length: 6,
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                      padding:
                          EdgeInsetsDirectional.only(top: 20.h, bottom: 20.h),
                      child: PrimaryButtonComponent(
                        onTap: () => onConfirm(),
                        text: StringsAssetsConstants.verification,
                        isLoading: loading,
                      )),
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
      ),
    );
  }
}
