import 'package:country_pickers/country.dart';
import 'package:country_pickers/country_picker_dropdown.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';
import 'package:solvodev_mobile_structure/app/modules/get_started/views/components/otp_verification_window_component.dart';

import '../controllers/get_started_controller.dart';

class GetStartedView extends GetView<GetStartedController> {
  const GetStartedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                SizedBox(height: 20.h),
                SizedBox(
                  height: 50.h,
                  child: GetBuilder<GetStartedController>(
                      id: GetBuildersIdsConstants.getStartedTap,
                      builder: (logic) {
                        return CustomSlidingSegmentedControl<int>(
                          initialValue: 1,
                          fixedWidth: 0.35.sw,
                          //height: 40.h,
                          children: {
                            1: Text(StringsAssetsConstants.signIn,
                                style: TextStyles.largeBodyTextStyle(context)
                                    .copyWith(
                                  color: logic.selectedTabIndex == 1
                                      ? MainColors.whiteColor
                                      : MainColors.textColor(context),
                                )),
                            2: Text(
                              StringsAssetsConstants.signUp,
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: logic.selectedTabIndex == 2
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
                              logic.changeSelectedTapIndex(v),
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
                SizedBox(height: 15.h),
                GetBuilder<GetStartedController>(
                    id: GetBuildersIdsConstants.getStartedTap,
                    builder: (logic) {
                      return SizedBox(
                        child: logic.selectedTabIndex == 1
                            ? Form(
                                key: logic.signInFormKey,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          StringsAssetsConstants.welcome,
                                          style:
                                              TextStyles.mediumLabelTextStyle(
                                                  context),
                                        ),
                                      )
                                          .animate(delay: (50).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      Center(
                                        child: Text(
                                          StringsAssetsConstants
                                              .signInDescription,
                                          style: TextStyles.mediumBodyTextStyle(
                                              context),
                                        ),
                                      )
                                          .animate(delay: (100).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 20.h),
                                      TextInputComponent(
                                        focusNode: logic.phoneNumberFocusNode,
                                        controller: logic.phoneNumberController,
                                        nextNode: logic.passwordFocusNode,
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
                                                  MainColors.backgroundColor(
                                                      context),
                                              itemBuilder: (country) => Row(
                                                children: <Widget>[
                                                  CountryPickerUtils
                                                      .getDefaultFlagImage(
                                                          country),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    "+${country.phoneCode}",
                                                    style: TextStyles
                                                            .mediumBodyTextStyle(
                                                                context)
                                                        .copyWith(
                                                      fontFamily:
                                                          FontsFamilyAssetsConstants
                                                              .bold,
                                                    ),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              ),
                                              itemFilter: (c) =>
                                                  ['SA'].contains(c.isoCode),
                                              priorityList: [
                                                CountryPickerUtils
                                                    .getCountryByIsoCode('SA'),
                                              ],
                                              sortComparator:
                                                  (Country a, Country b) => a
                                                      .isoCode
                                                      .compareTo(b.isoCode),
                                              onValuePicked:
                                                  (Country country) {},
                                            ),
                                            SizedBox(width: 10.w),
                                          ],
                                        ),
                                        validate: (value) =>
                                            ValidatorUtil.phoneValidation(value,
                                                customMessage:
                                                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.phoneNumber}'),
                                      )
                                          .animate(delay: (200).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 15.h),
                                      GetBuilder<GetStartedController>(
                                        id: GetBuildersIdsConstants
                                            .signInPasswordInput,
                                        builder: (logic) {
                                          return TextInputComponent(
                                            focusNode: logic.passwordFocusNode,
                                            controller:
                                                logic.passwordController,
                                            obscureText:
                                                logic.passwordVisibility,
                                            hint:
                                                '${StringsAssetsConstants.enter} ${StringsAssetsConstants.password}...',
                                            suffix: Row(
                                              children: [
                                                SizedBox(width: 10.w),
                                                GestureDetector(
                                                  onTap: () => logic
                                                      .togglePasswordVisibility(),
                                                  child: SvgPicture.asset(
                                                    logic.passwordVisibility
                                                        ? IconsAssetsConstants
                                                            .showIcon
                                                        : IconsAssetsConstants
                                                            .hideIcon,
                                                    width: 22.r,
                                                    height: 22.r,
                                                    color:
                                                        MainColors.primaryColor,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w),
                                              ],
                                            ),
                                            validate: (value) => ValidatorUtil
                                                .passwordValidation(value,
                                                    customMessage:
                                                        StringsAssetsConstants
                                                            .passwordValidation),
                                          );
                                        },
                                      )
                                          .animate(delay: (250).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 40.h),
                                      GetBuilder<GetStartedController>(
                                              id: GetBuildersIdsConstants
                                                  .signInButton,
                                              builder: (logic) {
                                                return PrimaryButtonComponent(
                                                  onTap: () => logic.signIn(),
                                                  text: StringsAssetsConstants
                                                      .signIn,
                                                  width: 0.4.sw,
                                                  isLoading:
                                                      logic.signInLoading,
                                                );
                                              })
                                          .animate(delay: (300).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 40.h),
                                      Center(
                                        child: Text(
                                          StringsAssetsConstants.forgotPassword,
                                          style: TextStyles.largeBodyTextStyle(
                                                  context)
                                              .copyWith(
                                            color: MainColors.primaryColor,
                                          ),
                                        ),
                                      )
                                          .animate(delay: (350).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 40.h),
                                    ],
                                  ),
                                ),
                              )
                            : Form(
                                key: controller.signUpFormKey,
                                child: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 40.w),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          StringsAssetsConstants.welcome,
                                          style:
                                              TextStyles.mediumLabelTextStyle(
                                                  context),
                                        ),
                                      )
                                          .animate(delay: (50).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      Center(
                                        child: Text(
                                          StringsAssetsConstants
                                              .signUpDescription,
                                          style: TextStyles.mediumBodyTextStyle(
                                              context),
                                        ),
                                      )
                                          .animate(delay: (100).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 20.h),
                                      TextInputComponent(
                                        focusNode: logic.phoneNumberFocusNode,
                                        controller: logic.phoneNumberController,
                                        nextNode: logic.passwordFocusNode,
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
                                                  MainColors.backgroundColor(
                                                      context),
                                              itemBuilder: (country) => Row(
                                                children: <Widget>[
                                                  CountryPickerUtils
                                                      .getDefaultFlagImage(
                                                          country),
                                                  SizedBox(width: 5.w),
                                                  Text(
                                                    "+${country.phoneCode}",
                                                    style: TextStyles
                                                            .mediumBodyTextStyle(
                                                                context)
                                                        .copyWith(
                                                      fontFamily:
                                                          FontsFamilyAssetsConstants
                                                              .bold,
                                                    ),
                                                    textDirection:
                                                        TextDirection.ltr,
                                                  ),
                                                ],
                                              ),
                                              itemFilter: (c) =>
                                                  ['SA'].contains(c.isoCode),
                                              priorityList: [
                                                CountryPickerUtils
                                                    .getCountryByIsoCode('SA'),
                                              ],
                                              sortComparator:
                                                  (Country a, Country b) => a
                                                      .isoCode
                                                      .compareTo(b.isoCode),
                                              onValuePicked:
                                                  (Country country) {},
                                            ),
                                            SizedBox(width: 10.w),
                                          ],
                                        ),
                                        validate: (value) =>
                                            ValidatorUtil.phoneValidation(value,
                                                customMessage:
                                                    '${StringsAssetsConstants.check} ${StringsAssetsConstants.phoneNumber}'),
                                      )
                                          .animate(delay: (200).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 40.h),
                                      GetBuilder<GetStartedController>(
                                              id: GetBuildersIdsConstants
                                                  .checkingUserButton,
                                              builder: (logic) {
                                                return PrimaryButtonComponent(
                                                  onTap: () =>
                                                      logic.checkingUser(),
                                                  text: StringsAssetsConstants
                                                      .signUp,
                                                  width: 0.4.sw,
                                                  isLoading:
                                                      logic.checkingUserLoading,
                                                );
                                              })
                                          .animate(delay: (300).ms)
                                          .fadeIn(
                                              duration: 900.ms, delay: 300.ms)
                                          .move(
                                            begin: const Offset(200, 0),
                                            duration: 500.ms,
                                          ),
                                      SizedBox(height: 40.h),
                                    ],
                                  ),
                                ),
                              ),
                      );
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showOtpConfirmationWindow() {
    BottomSheetComponent.show(Get.context!,
        body: const OtpVerificationWindowComponent());
  }
}
