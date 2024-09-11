import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

import '../controllers/my_account_controller.dart';

class MyAccountView extends GetView<MyAccountController> {
  const MyAccountView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: HeaderComponent(
          isBack: false,
          prefixWidget: Text(
            StringsAssetsConstants.myAccount,
            style: TextStyles.largeLabelTextStyle(context),
          ),
        ),
        body: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  decoration: BoxDecoration(
                    color: MainColors.backgroundColor(context),
                    borderRadius: BorderRadius.circular(12.r),
                    boxShadow: [
                      BoxShadow(
                        color: MainColors.shadowColor(context)!,
                        blurRadius: 10.r,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(18.r),
                        width: 90.r,
                        height: 90.r,
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
                      SizedBox(width: 14.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                StringsAssetsConstants.welcome,
                                style: TextStyles.mediumLabelTextStyle(context),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                '${Get.find<UserController>().user?.lastName}',
                                style: TextStyles.mediumLabelTextStyle(context),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
