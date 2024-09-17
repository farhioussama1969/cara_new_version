import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/otp_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/text/animated_type_text_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/get_started/controllers/get_started_controller.dart';

class OtpVerificationWindowComponent extends StatelessWidget {
  const OtpVerificationWindowComponent({super.key});

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
                    length: 6,
                    controller: Get.find<GetStartedController>().otpController,
                  ),
                  SizedBox(height: 15.h),
                  GetBuilder<GetStartedController>(
                      id: GetBuildersIdsConstants.signInResendOtpButton,
                      builder: (logic) {
                        return Center(
                          child: (!logic.isAllowedToResendOtp)
                              ? CustomTimer(
                                  controller: logic.timerController,
                                  begin: const Duration(seconds: 60),
                                  end: const Duration(),
                                  onChangeState: (status) {
                                    if (status == CustomTimerState.finished) {
                                      logic.changeAllowedResendOtp(true);
                                    }
                                  },
                                  builder: (time) {
                                    return RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: '00:${time.seconds}',
                                        style: TextStyles.mediumBodyTextStyle(
                                            context),
                                        children: <TextSpan>[],
                                      ),
                                    );
                                  },
                                )
                              : (!logic.resendOtpLoading)
                                  ? RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: StringsAssetsConstants
                                            .youDidntReceive,
                                        style: TextStyles.mediumBodyTextStyle(
                                            context),
                                        children: <TextSpan>[
                                          TextSpan(
                                            text:
                                                '  ${StringsAssetsConstants.resend}',
                                            recognizer: TapGestureRecognizer()
                                              ..onTap = () => logic.resendOtp(),
                                            style:
                                                TextStyles.mediumBodyTextStyle(
                                                        context)
                                                    .copyWith(
                                              fontFamily:
                                                  FontsFamilyAssetsConstants
                                                      .bold,
                                              color: MainColors.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  : LoadingComponent(
                                      color: MainColors.primaryColor,
                                    ),
                        );
                      }),
                  SizedBox(height: 15.h),
                  Padding(
                    padding:
                        EdgeInsetsDirectional.only(top: 20.h, bottom: 20.h),
                    child: GetBuilder<GetStartedController>(
                        id: GetBuildersIdsConstants.signInOtpVerificationButton,
                        builder: (logic) {
                          return PrimaryButtonComponent(
                            onTap: () => logic.verifyOtp(),
                            text: StringsAssetsConstants.verification,
                            isLoading: logic.verifyOtpLoading,
                          );
                        }),
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
      ),
    );
  }
}
