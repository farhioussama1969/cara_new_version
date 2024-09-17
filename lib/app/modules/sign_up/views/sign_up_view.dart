import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';

import '../controllers/sign_up_controller.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);
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
                Form(
                  key: controller.signUpFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40.w),
                    child: Column(
                      children: [
                        Center(
                          child: Text(
                            StringsAssetsConstants.signUp,
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
                            StringsAssetsConstants.signUpDescription,
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
                          focusNode: controller.fullNameFocusNode,
                          controller: controller.fullNameController,
                          nextNode: controller.passwordFocusNode,
                          textInputType: TextInputType.name,
                          hint:
                              '${StringsAssetsConstants.enter} ${StringsAssetsConstants.fullName}...',
                          validate: (value) => ValidatorUtil.stringLengthValidation(
                              value, 3,
                              customMessage:
                                  '${StringsAssetsConstants.check} ${StringsAssetsConstants.fullName}'),
                        )
                            .animate(delay: (200).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 15.h),
                        GetBuilder<SignUpController>(
                          id: GetBuildersIdsConstants.signUpPasswordInput,
                          builder: (logic) {
                            return TextInputComponent(
                              focusNode: logic.passwordFocusNode,
                              nextNode: logic.confirmPasswordFocusNode,
                              controller: logic.passwordController,
                              obscureText: logic.passwordVisibility,
                              hint:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.password}...',
                              suffix: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () =>
                                        logic.togglePasswordVisibility(),
                                    child: SvgPicture.asset(
                                      logic.passwordVisibility
                                          ? IconsAssetsConstants.showIcon
                                          : IconsAssetsConstants.hideIcon,
                                      width: 22.r,
                                      height: 22.r,
                                      color: MainColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                ],
                              ),
                              validate: (value) =>
                                  ValidatorUtil.passwordValidation(
                                      value,
                                      customMessage: StringsAssetsConstants
                                          .passwordValidation),
                            );
                          },
                        )
                            .animate(delay: (250).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 15.h),
                        GetBuilder<SignUpController>(
                          id: GetBuildersIdsConstants
                              .signUpConfirmPasswordInput,
                          builder: (logic) {
                            return TextInputComponent(
                              focusNode: logic.confirmPasswordFocusNode,
                              controller: logic.confirmPasswordController,
                              obscureText: logic.confirmPasswordVisibility,
                              hint:
                                  '${StringsAssetsConstants.enter} ${StringsAssetsConstants.passwordConfirmation}...',
                              suffix: Row(
                                children: [
                                  SizedBox(width: 10.w),
                                  GestureDetector(
                                    onTap: () =>
                                        logic.toggleConfirmPasswordVisibility(),
                                    child: SvgPicture.asset(
                                      logic.confirmPasswordVisibility
                                          ? IconsAssetsConstants.showIcon
                                          : IconsAssetsConstants.hideIcon,
                                      width: 22.r,
                                      height: 22.r,
                                      color: MainColors.primaryColor,
                                    ),
                                  ),
                                  SizedBox(width: 20.w),
                                ],
                              ),
                              validate: (value) =>
                                  ValidatorUtil.passwordConfirmationValidation(
                                      value, controller.passwordController.text,
                                      customMessage: StringsAssetsConstants
                                          .passwordValidation),
                            );
                          },
                        )
                            .animate(delay: (250).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 40.h),
                        GetBuilder<SignUpController>(
                                id: GetBuildersIdsConstants.signUpButton,
                                builder: (logic) {
                                  return PrimaryButtonComponent(
                                    onTap: () => logic.signUp(),
                                    text: StringsAssetsConstants.signIn,
                                    width: 0.4.sw,
                                    isLoading: logic.signUpLoading,
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
}
