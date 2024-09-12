import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../controllers/policy_privacy_controller.dart';

class PolicyPrivacyView extends GetView<PolicyPrivacyController> {
  const PolicyPrivacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        actionWidget: Text(
          StringsAssetsConstants.policyPrivacy,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            SizedBox(height: 20.h),
            SvgPicture.asset(
              ImagesAssetsConstants.policyImage,
              width: 0.7.sw,
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: GetBuilder<PolicyPrivacyController>(
                id: GetBuildersIdsConstants.policyBody,
                builder: (logic) {
                  return logic.getPolicyLoading
                      ? Padding(
                          padding: EdgeInsetsDirectional.only(
                              top: 50.h, bottom: 50.h),
                          child: const Center(
                            child: LoadingComponent(),
                          ),
                        )
                      : SingleChildScrollView(
                          physics: const BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w),
                            child: HtmlWidget(
                              logic.policy,
                              textStyle:
                                  TextStyles.mediumBodyTextStyle(context),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
