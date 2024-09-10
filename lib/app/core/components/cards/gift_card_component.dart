import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:solvodev_mobile_structure/app/core/components/images/network_image_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_model.dart';

class GiftCardComponent extends StatelessWidget {
  const GiftCardComponent({super.key, required this.gift});

  final GiftModel? gift;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(
          color: MainColors.primaryColor,
          width: 1.5.r,
        ),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            height: 60.r,
            width: 60.r,
            child: NetworkImageComponent(imageLink: '${gift?.image}'),
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        gift?.title ?? '',
                        style: TextStyles.mediumLabelTextStyle(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: HtmlWidget(
                        '${gift?.description}',
                        textStyle: TextStyles.mediumBodyTextStyle(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${gift?.numberWashes} ',
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.primaryColor,
                                fontFamily: FontsFamilyAssetsConstants.bold,
                              ),
                            ),
                            TextSpan(
                              text: StringsAssetsConstants.washes,
                              style: TextStyles.largeBodyTextStyle(context),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      '${gift?.amount?.floor()} ${StringsAssetsConstants.currency}',
                      style: TextStyles.mediumLabelTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontFamily: FontsFamilyAssetsConstants.bold,
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
