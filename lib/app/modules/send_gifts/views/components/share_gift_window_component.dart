import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/inputs/text_input_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';

import '../../../../core/components/buttons/primary_button_component.dart';

class ShareGiftWindowComponent extends StatelessWidget {
  const ShareGiftWindowComponent(
      {super.key,
      required this.noteController,
      required this.onView,
      required this.onShare,
      this.gift});

  final TextEditingController noteController;
  final Function onView;
  final Function onShare;
  final GiftCouponModel? gift;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding:
              EdgeInsetsDirectional.only(start: 20.w, end: 20.w, top: 15.h),
          decoration: BoxDecoration(
            color: MainColors.backgroundColor(context),
            borderRadius: BorderRadiusDirectional.vertical(
              top: Radius.circular(30.r),
            ),
          ),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    StringsAssetsConstants.giftShare,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 20.h),
                Column(
                  children: [
                    SizedBox(height: 30.h),
                    TextInputComponent(
                      controller: noteController,
                      borderRadius: 10.r,
                      maxLines: 4,
                      hint:
                          '${StringsAssetsConstants.giftShareText} (${StringsAssetsConstants.optional})',
                    ),
                  ],
                ),
                SizedBox(height: 30.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryButtonComponent(
                      onTap: () => onShare(),
                      text: StringsAssetsConstants.share,
                      width: 0.3.sw,
                    )
                        .animate(delay: (150).ms)
                        .fadeIn(duration: 900.ms, delay: 300.ms)
                        .move(
                          begin: const Offset(0, 200),
                          duration: 500.ms,
                        ),
                    SizedBox(width: 20.w),
                    PrimaryButtonComponent(
                      onTap: () => onView(),
                      text: StringsAssetsConstants.view,
                      width: 0.3.sw,
                    )
                        .animate(delay: (150).ms)
                        .fadeIn(duration: 900.ms, delay: 300.ms)
                        .move(
                          begin: const Offset(0, 200),
                          duration: 500.ms,
                        ),
                  ],
                ),
                SizedBox(height: 30.h),
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
    );
  }
}
