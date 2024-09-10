import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/tag_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';

class OldGiftCardComponent extends StatelessWidget {
  const OldGiftCardComponent({super.key, required this.giftCoupon});

  final GiftCouponModel? giftCoupon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        borderRadius: BorderRadius.circular(12.r),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '${StringsAssetsConstants.giftId}: ',
                    style: TextStyles.mediumBodyTextStyle(context),
                    children: [
                      TextSpan(
                        text: '${giftCoupon?.id}',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          color: MainColors.primaryColor,
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${StringsAssetsConstants.expiryDate}: ',
                  style: TextStyles.mediumBodyTextStyle(context),
                  children: [
                    TextSpan(
                      text: '${giftCoupon?.endDate}',
                      style: TextStyles.largeBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontFamily: FontsFamilyAssetsConstants.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: '${StringsAssetsConstants.giftCode}: ',
                    style: TextStyles.mediumBodyTextStyle(context),
                    children: [
                      TextSpan(
                        text: '${giftCoupon?.code}',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          color: MainColors.primaryColor,
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: '${StringsAssetsConstants.giftUtilizations}: ',
                  style: TextStyles.mediumBodyTextStyle(context),
                  children: [
                    TextSpan(
                      text: '${giftCoupon?.numberOfUses}',
                      style: TextStyles.largeBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                        fontFamily: FontsFamilyAssetsConstants.bold,
                      ),
                    ),
                    TextSpan(
                      text: '/${giftCoupon?.numberWashes}',
                      style: TextStyles.mediumBodyTextStyle(context).copyWith(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await Clipboard.setData(
                      ClipboardData(text: "${giftCoupon?.code}"));
                  ToastComponent.showInfoToast(Get.context!,
                      text: StringsAssetsConstants.giftCopied);
                },
                child: TagComponent(
                  title: StringsAssetsConstants.copy,
                  textStyle: TextStyles.mediumBodyTextStyle(context).copyWith(
                    color: MainColors.whiteColor,
                  ),
                ),
              ),
              SizedBox(width: 10.w),
              GestureDetector(
                onTap: () {},
                child: TagComponent(
                  title: StringsAssetsConstants.share,
                  textStyle: TextStyles.mediumBodyTextStyle(context).copyWith(
                    color: MainColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void shareGiftWindow() {}
}
