import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/tag_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class SendGiftCardComponent extends StatelessWidget {
  const SendGiftCardComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 230.h,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: MainColors.primaryColor,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Image.asset(
              ImagesAssetsConstants.authenticationBackgroundImage,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Positioned.fill(
          child: Container(
            padding: EdgeInsets.all(20.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            StringsAssetsConstants
                                .sendWashGiftsToYourFriendsAndLovedOnes,
                            style:
                                TextStyles.largeBodyTextStyle(context).copyWith(
                              color: MainColors.whiteColor,
                              fontFamily: FontsFamilyAssetsConstants.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Text(
                            StringsAssetsConstants.sendGistCardDescription,
                            style: TextStyles.mediumBodyTextStyle(context)
                                .copyWith(
                              color: MainColors.whiteColor,
                            ),
                            maxLines: 4,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10.w),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(width: 20.w),
                    TagComponent(
                      title: StringsAssetsConstants.sendNow,
                      backgroundColor: MainColors.whiteColor,
                      textColor: MainColors.primaryColor,
                      textStyle:
                          TextStyles.mediumBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontFamily: FontsFamilyAssetsConstants.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
