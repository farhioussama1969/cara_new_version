import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';
import 'package:solvodev_mobile_structure/app/modules/reset_password/controllers/reset_password_controller.dart';

import '../controllers/remind_password_controller.dart';
import 'components/otp_verification_window_component.dart';

class RemindPasswordView extends GetView<RemindPasswordController> {
  const RemindPasswordView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
      ),
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  ImagesAssetsConstants.authenticationBackgroundImage,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SafeArea(
            child: ScrollableBodyComponent(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      SizedBox(height: 20.h),
                      SvgPicture.asset(
                        LogosAssetsConstants.appLogoVector,
                        width: 140.w,
                      )
                          .animate(delay: (50).ms)
                          .fadeIn(duration: 900.ms, delay: 300.ms)
                          .shimmer(
                              blendMode: BlendMode.srcOver,
                              color: MainColors.backgroundColor(context)
                                  ?.withOpacity(0.3))
                          .move(
                              begin: const Offset(0, -300),
                              curve: Curves.easeOutQuad),
                      SizedBox(height: 5.h),
                      Center(
                        child: Text(
                          StringsAssetsConstants.appTitle,
                          style: TextStyles.largeBodyTextStyle(context),
                        ),
                      )
                          .animate(delay: (100).ms)
                          .fadeIn(duration: 900.ms, delay: 300.ms)
                          .shimmer(
                              blendMode: BlendMode.srcOver,
                              color: MainColors.backgroundColor(context)
                                  ?.withOpacity(0.3))
                          .move(
                            begin: const Offset(0, -200),
                          ),
                    ],
                  ),
                ),
                SizedBox(height: 15.h),
                Form(
                  key: controller.formKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            StringsAssetsConstants.resetPassword,
                            style: TextStyles.mediumLabelTextStyle(context),
                          ),
                        )
                            .animate(delay: (50).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        Center(
                          child: Text(
                            StringsAssetsConstants.resetPasswordDescription,
                            style: TextStyles.mediumBodyTextStyle(context),
                          ),
                        )
                            .animate(delay: (100).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 20.h),
                        TextInputComponent(
                          controller: controller.phoneController,
                          textInputType: TextInputType.phone,
                          maxLength: 9,
                          hint:
                              '${StringsAssetsConstants.enter} ${StringsAssetsConstants.phoneNumber}...',
                          prefix: Row(
                            children: [
                              SizedBox(width: 20.w),
                              CountryPickerDropdown(
                                initialValue: 'SA',
                                iconSize: 20.r,
                                dropdownColor:
                                    MainColors.backgroundColor(context),
                                itemBuilder: (country) => Row(
                                  children: <Widget>[
                                    CountryPickerUtils.getDefaultFlagImage(
                                        country),
                                    SizedBox(width: 5.w),
                                    Text(
                                      "+${country.phoneCode}",
                                      style: TextStyles.mediumBodyTextStyle(
                                              context)
                                          .copyWith(
                                        fontFamily:
                                            FontsFamilyAssetsConstants.bold,
                                      ),
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ],
                                ),
                                itemFilter: (c) => ['SA'].contains(c.isoCode),
                                priorityList: [
                                  CountryPickerUtils.getCountryByIsoCode('SA'),
                                ],
                                sortComparator: (Country a, Country b) =>
                                    a.isoCode.compareTo(b.isoCode),
                                onValuePicked: (Country country) {},
                              ),
                              SizedBox(width: 10.w),
                            ],
                          ),
                          validate: (value) => ValidatorUtil.phoneValidation(
                              value,
                              customMessage:
                                  '${StringsAssetsConstants.check} ${StringsAssetsConstants.phoneNumber}'),
                        )
                            .animate(delay: (200).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 40.h),
                        GetBuilder<RemindPasswordController>(
                                id: GetBuildersIdsConstants.resetPasswordButton,
                                builder: (logic) {
                                  return PrimaryButtonComponent(
                                    onTap: () => logic.sendOtp(),
                                    text: StringsAssetsConstants.confirm,
                                    width: 0.4.sw,
                                    isLoading: logic.sendOtpLoading,
                                  );
                                })
                            .animate(delay: (300).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 40.h),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showOtpConfirmationWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<RemindPasswordController>(
        id: GetBuildersIdsConstants.otpVerificationWindow,
        builder: (logic) {
          return OtpVerificationWindowComponent(
            onConfirm: () => logic.verifyOtp(),
            otpController: logic.otpController,
            loading: logic.verifyOtpLoading,
          );
        },
      ),
    );
  }
}
