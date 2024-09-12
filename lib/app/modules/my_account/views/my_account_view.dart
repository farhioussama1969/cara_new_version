import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/windows/confirm_window_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/my_account/views/components/account_item_card_component.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

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
                margin: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
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
                        SizedBox(height: 8.h),
                        Row(
                          children: [
                            Text(
                              '${Get.find<UserController>().user?.username}',
                              style: TextStyles.largeBodyTextStyle(context),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              )
                  .animate(delay: (100).ms)
                  .fadeIn(duration: 900.ms, delay: 300.ms)
                  .move(
                    begin: const Offset(200, 0),
                    duration: 500.ms,
                  ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.w),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
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
                child: Column(
                  children: [
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.editIcon,
                      title: StringsAssetsConstants.myInformation,
                      onTap: () => Get.toNamed(Routes.EDIT_INFORMATION),
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.notificationsIcon,
                      title: StringsAssetsConstants.notifications,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.walletIcon,
                      title: StringsAssetsConstants.myWallet,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.shieldIcon,
                      title: StringsAssetsConstants.policyPrivacy,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.aboutUsIcon,
                      title: StringsAssetsConstants.aboutTheApp,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.whatsappLogoIcon,
                      title: StringsAssetsConstants.contactUs,
                      onTap: () {},
                    ),
                    SizedBox(height: 10.h),
                    Divider(
                      color: MainColors.textColor(context)!.withOpacity(0.2),
                    ),
                    SizedBox(height: 10.h),
                    AccountItemCardComponent(
                      iconPath: IconsAssetsConstants.logoutIcon,
                      title: StringsAssetsConstants.logout,
                      iconColor: MainColors.errorColor(context),
                      onTap: () => showLogoutConfirmationWindow(),
                    ),
                  ],
                ),
              )
                  .animate(delay: (200).ms)
                  .fadeIn(duration: 900.ms, delay: 300.ms)
                  .move(
                    begin: const Offset(200, 0),
                    duration: 500.ms,
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConfirmationWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<MyAccountController>(
          id: GetBuildersIdsConstants.logoutConfirmationButton,
          builder: (logic) {
            return ConfirmWindowComponent(
              title: StringsAssetsConstants.logout,
              subtitle: StringsAssetsConstants.logoutConfirmationText,
              baseColor: MainColors.errorColor(Get.context!),
              iconPath: IconsAssetsConstants.logoutIcon,
              onCancel: () => Get.back(),
              isLoading: logic.logoutLoading,
              onConfirm: () => logic.logout(),
            );
          }),
    );
  }
}
