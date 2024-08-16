import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:solvodev_mobile_structure/app/core/constants/images_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

class HomeSubscriptionBannerComponent extends StatelessWidget {
  const HomeSubscriptionBannerComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 200.h,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: MainColors.primaryColor,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        children: [
          Image.asset(
            ImagesAssetsConstants.subscriptionImage,
            width: 120.r,
            height: 120.r,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsAssetsConstants.homeSubscriptionTitle,
                        style:
                            TextStyles.mediumLabelTextStyle(context).copyWith(
                          color: MainColors.whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        StringsAssetsConstants.homeSubscriptionDescription,
                        style: TextStyles.mediumBodyTextStyle(context).copyWith(
                          color: MainColors.whiteColor,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
