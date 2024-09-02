import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/modules/gifts/views/components/free_washes_list_component.dart';
import 'package:solvodev_mobile_structure/app/modules/gifts/views/components/send_gift_card_component.dart';

import '../controllers/gifts_controller.dart';

class GiftsView extends GetView<GiftsController> {
  const GiftsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: false,
        prefixWidget: Text(
          StringsAssetsConstants.giftsAndFreeWashes,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              GetBuilder<GiftsController>(
                id: GetBuildersIdsConstants.giftsFreeWashingConfig,
                builder: (logic) {
                  return Column(
                    children: [
                      SizedBox(height: 30.h),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: MainColors.disableColor(context)!
                                  .withOpacity(0.4),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Text(
                              StringsAssetsConstants.freeWashes,
                              style: TextStyles.mediumLabelTextStyle(context),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: MainColors.disableColor(context)!
                                  .withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      CircularPercentIndicator(
                        radius: 45.0,
                        lineWidth: 10.0,
                        animation: true,
                        percent: min(
                            ((logic.freeWashingConfig?.washingCount ?? 0) /
                                (logic.freeWashingConfig?.washingCountAllow ??
                                    1)),
                            1),
                        center: Text(
                          "${logic.freeWashingConfig?.washingCount ?? 0} / ${logic.freeWashingConfig?.washingCountAllow ?? 0}",
                          style: TextStyles.largeBodyTextStyle(context),
                          textDirection: TextDirection.ltr,
                        ),
                        circularStrokeCap: CircularStrokeCap.round,
                        progressColor: MainColors.primaryColor,
                      ),
                      SizedBox(height: 10.h),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: !((logic.freeWashingConfig?.washingCount ?? 0) >=
                                (logic.freeWashingConfig?.washingCountAllow ??
                                    0))
                            ? RichText(
                                text: TextSpan(
                                  text: '',
                                  style:
                                      TextStyles.mediumLabelTextStyle(context),
                                  children: [
                                    TextSpan(
                                        text:
                                            '${StringsAssetsConstants.remaining} ',
                                        style: TextStyles.largeBodyTextStyle(
                                            context)),
                                    TextSpan(
                                      text:
                                          ' ${(logic.freeWashingConfig?.washingCountAllow ?? 0) - (logic.freeWashingConfig?.washingCount ?? 0)} ',
                                      style:
                                          TextStyles.largeBodyTextStyle(context)
                                              .copyWith(
                                        color: MainColors.primaryColor,
                                        fontFamily:
                                            FontsFamilyAssetsConstants.bold,
                                      ),
                                    ),
                                    TextSpan(
                                        text:
                                            '${StringsAssetsConstants.washingOrdersLeftToGetAOneFree} ',
                                        style: TextStyles.largeBodyTextStyle(
                                            context)),
                                  ],
                                ),
                              )
                            : RichText(
                                text: TextSpan(
                                  text: '',
                                  children: [
                                    TextSpan(
                                        text:
                                            '${StringsAssetsConstants.youGot} ',
                                        style: TextStyles.largeBodyTextStyle(
                                            context)),
                                    TextSpan(
                                      text:
                                          ' ${logic.freeWashingConfig?.freeOrder}  ',
                                      style:
                                          TextStyles.largeBodyTextStyle(context)
                                              .copyWith(
                                        color: MainColors.primaryColor,
                                        fontFamily:
                                            FontsFamilyAssetsConstants.bold,
                                      ),
                                    ),
                                    TextSpan(
                                      text:
                                          '${StringsAssetsConstants.freeWashesReadyToUse} ',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                              ),
                      ),
                      SizedBox(height: 20.h),
                      FreeWashingListComponent(
                        currentOrderNumber:
                            logic.freeWashingConfig?.washingCount ?? 0,
                        maxOrdersNumber:
                            logic.freeWashingConfig?.washingCountAllow ?? 0,
                      ),
                    ],
                  );
                },
              ),
              Column(
                children: [
                  SizedBox(height: 30.h),
                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: MainColors.disableColor(context)!
                              .withOpacity(0.4),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          StringsAssetsConstants.gifts,
                          style: TextStyles.mediumLabelTextStyle(context),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          color: MainColors.disableColor(context)!
                              .withOpacity(0.4),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  const SendGiftCardComponent(),
                  SizedBox(height: 40.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
