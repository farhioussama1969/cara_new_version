import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/validator_util.dart';

import '../../../core/constants/logos_assets_constants.dart';
import '../../../core/styles/main_colors.dart';
import '../controllers/edit_information_controller.dart';

class EditInformationView extends GetView<EditInformationController> {
  const EditInformationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        actionWidget: Text(
          StringsAssetsConstants.myInformation,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ScrollableBodyComponent(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(18.r),
              width: 100.r,
              height: 100.r,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(1000.r),
                border: Border.all(
                  color: MainColors.primaryColor,
                  width: 3.r,
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  LogosAssetsConstants.appLogoVector,
                  color: MainColors.primaryColor,
                ),
              ),
            ),
            SizedBox(height: 40.h),
            Form(
              key: controller.formKey,
              child: TextInputComponent(
                controller: controller.usernameController,
                hint:
                    '${StringsAssetsConstants.enter} ${StringsAssetsConstants.username}...',
                label: StringsAssetsConstants.username,
                isLabelOutside: true,
                validate: (value) => ValidatorUtil.stringLengthValidation(
                  value,
                  3,
                  customMessage:
                      '${StringsAssetsConstants.check} ${StringsAssetsConstants.username}',
                ),
              ),
            ),
            SizedBox(height: 20.h),
            const Expanded(child: SizedBox.shrink()),
            GetBuilder<EditInformationController>(
                id: GetBuildersIdsConstants.updateProfileButton,
                builder: (logic) {
                  return PrimaryButtonComponent(
                    onTap: () => logic.updateProfile(),
                    text: StringsAssetsConstants.update,
                    isLoading: logic.updateProfileLoading,
                    width: 0.7.sw,
                  );
                }),
            SizedBox(height: 40.h),
            Center(
              child: Text(
                StringsAssetsConstants.deleteMyAccount,
                style: TextStyles.largeBodyTextStyle(context).copyWith(
                  color: MainColors.errorColor(context),
                ),
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      ),
    );
  }
}
