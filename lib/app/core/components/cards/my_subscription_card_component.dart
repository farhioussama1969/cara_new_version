import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/user_subscription_model.dart';

class MySubscriptionCardComponent extends StatelessWidget {
  const MySubscriptionCardComponent(
      {super.key,
      this.subscription,
      required this.index,
      required this.isSelected});

  final UserSubscriptionModel? subscription;
  final int index;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(
          color: isSelected
              ? MainColors.primaryColor
              : MainColors.transparentColor,
          width: 2.r,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 5.r,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          SvgPicture.asset(
            IconsAssetsConstants.caraIcon,
            width: 25.r,
            height: 25.r,
            color: MainColors.primaryColor,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${StringsAssetsConstants.subscription}: ',
                          style:
                              TextStyles.largeBodyTextStyle(context).copyWith(
                            fontFamily: FontsFamilyAssetsConstants.bold,
                          ),
                          children: [
                            TextSpan(
                              text: '${subscription?.id}',
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${StringsAssetsConstants.remaining}: ',
                        style:
                            TextStyles.mediumBodyTextStyle(context).copyWith(),
                        children: [
                          TextSpan(
                            text: '${subscription?.remainingWashes}',
                            style:
                                TextStyles.largeBodyTextStyle(context).copyWith(
                              color: MainColors.primaryColor,
                            ),
                          ),
                          TextSpan(
                            text: '/${subscription?.total}',
                            style: TextStyles.smallBodyTextStyle(context),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          text: '${StringsAssetsConstants.endOn}: ',
                          style: TextStyles.mediumBodyTextStyle(context)
                              .copyWith(),
                          children: [
                            TextSpan(
                              text:
                                  '${DateTime.parse(subscription!.endDate!).difference(DateTime.now()).inDays} ',
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.primaryColor,
                              ),
                            ),
                            TextSpan(
                              text: StringsAssetsConstants.day,
                              style: TextStyles.smallBodyTextStyle(context),
                            ),
                          ],
                        ),
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
