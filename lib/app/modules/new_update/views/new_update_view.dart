import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/animations_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/app_version_info_service.dart';
import 'package:solvodev_mobile_structure/app/core/services/url_launcher_service.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/config_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

import '../controllers/new_update_controller.dart';

class NewUpdateView extends GetView<NewUpdateController> {
  const NewUpdateView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              AnimationsAssetsConstants.newUpdateAnimation,
              width: 320.r,
            ),
            SizedBox(height: 50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Text(
                  '${StringsAssetsConstants.newUpdate} (${controller.versionData?.priority == true ? StringsAssetsConstants.required : StringsAssetsConstants.optional})',
                  style: TextStyles.mediumLabelTextStyle(context).copyWith(
                    fontSize: 24.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Center(
                child: Text(
                  (controller.versionData?.priority == true)
                      ? StringsAssetsConstants.requiredUpdateDescription
                      : StringsAssetsConstants.optionalUpdateDescription,
                  style: TextStyles.largeBodyTextStyle(context).copyWith(
                    color: MainColors.textColor(context)!.withOpacity(0.8),
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 40.w),
              child: PrimaryButtonComponent(
                onTap: () => UrlLauncherService.openLink(
                  link: '${controller.versionData?.link}',
                ),
                text: StringsAssetsConstants.update,
              ),
            ),
            SizedBox(height: 40.h),
            if (controller.versionData?.priority != true)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Center(
                  child: InkWell(
                    onTap: () => Get.find<UserController>()
                        .initialize(skipUpdateChecker: true),
                    child: Text(
                      StringsAssetsConstants.updateLater,
                      style: TextStyles.largeBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontFamily: FontsFamilyAssetsConstants.bold,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
