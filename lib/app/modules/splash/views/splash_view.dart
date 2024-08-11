import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/animated_possition_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/theme_util.dart';
import 'package:solvodev_mobile_structure/app/modules/config_controller.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: 1.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: MainColors.backgroundColor(context),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            SizedBox(
                width: 1.sw,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      ThemeUtil.isDarkMode ? LogosAssetsConstants.appLogoLight : LogosAssetsConstants.appLogo,
                      width: 300.r,
                    ),
                  ],
                ).animate().blurXY(begin: 10, end: 0, duration: const Duration(milliseconds: 1500))),
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const LoadingComponent(),
                SizedBox(height: 15.h),
                GetBuilder<ConfigController>(
                    id: GetBuildersIdsConstants.splashVersionText,
                    builder: (logic) => logic.appVersion != null
                        ? Text(
                            '${StringsAssetsConstants.appName} (v${logic.appVersion})',
                            style: TextStyles.mediumLabelTextStyle(context).copyWith(),
                          )
                        : const SizedBox.shrink()),
                SizedBox(height: 5.h),
                Text(
                  StringsAssetsConstants.developedBy,
                  style: TextStyles.smallBodyTextStyle(context).copyWith(
                    fontFamily: FontsFamilyAssetsConstants.bold,
                  ),
                ),
                SizedBox(height: 30.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
