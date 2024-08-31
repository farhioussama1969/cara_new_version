import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/my_car_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/tag_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/layouts/scrollable_body_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/bottom_sheet_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/logos_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/modules/reservation_details/views/components/rating_window_component.dart';

import '../controllers/reservation_details_controller.dart';

class ReservationDetailsView extends GetView<ReservationDetailsController> {
  const ReservationDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        actionWidget: Text(
          StringsAssetsConstants.reservationDetails,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: ScrollableBodyComponent(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          children: [
            Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${StringsAssetsConstants.reservationNumber}:',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ),
                    Text(
                      '${controller.orderModel?.id ?? ''}',
                      style: TextStyles.largeBodyTextStyle(context).copyWith(
                        color: MainColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${StringsAssetsConstants.reservationDate}:',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text:
                            '${RelativeDateUtil.numToDay(DateTime.parse(controller.orderModel?.date ?? '').weekday)} ',
                        style: TextStyles.mediumBodyTextStyle(context),
                        children: [
                          TextSpan(
                            text:
                                '${DateTime.parse(controller.orderModel?.date ?? '').day} ',
                            style: TextStyles.mediumBodyTextStyle(context)
                                .copyWith(
                              color: MainColors.primaryColor,
                              fontFamily: FontsFamilyAssetsConstants.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${RelativeDateUtil.numToMonth(DateTime.parse(controller.orderModel?.date ?? '').month)} ',
                            style: TextStyles.mediumBodyTextStyle(context),
                          ),
                          TextSpan(
                            text:
                                '${DateTime.parse(controller.orderModel?.date ?? '').year} ',
                            style: TextStyles.mediumBodyTextStyle(context)
                                .copyWith(
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
                      child: Text(
                        '${StringsAssetsConstants.reservationTime}:',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: '',
                        style: TextStyles.mediumBodyTextStyle(context),
                        children: [
                          TextSpan(
                            text:
                                '${RelativeDateUtil.changeHourFormat(controller.orderModel?.time?.replaceAll('H', ''))} ',
                            style: TextStyles.mediumBodyTextStyle(context)
                                .copyWith(
                              color: MainColors.primaryColor,
                              fontFamily: FontsFamilyAssetsConstants.bold,
                            ),
                          ),
                          TextSpan(
                            text:
                                '${RelativeDateUtil.getAmPmFromTime(controller.orderModel?.time).substring(0, 5)} ',
                            style: TextStyles.mediumBodyTextStyle(context),
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
                      child: Text(
                        '${StringsAssetsConstants.reservationStatus}:',
                        style: TextStyles.largeBodyTextStyle(context).copyWith(
                          fontFamily: FontsFamilyAssetsConstants.bold,
                        ),
                      ),
                    ),
                    TagComponent(
                      title: controller.orderModel?.status == "Accepted"
                          ? StringsAssetsConstants.acceptedOrder
                          : controller.orderModel?.status == "Completed"
                              ? StringsAssetsConstants.orderCompleted
                              : controller.orderModel?.status == "In way"
                                  ? StringsAssetsConstants.onTheWay
                                  : StringsAssetsConstants.orderCanceled,
                      backgroundColor:
                          controller.orderModel?.status == "Accepted"
                              ? MainColors.successColor(context)
                              : controller.orderModel?.status == "Completed"
                                  ? MainColors.successColor(context)
                                  : controller.orderModel?.status == "In way"
                                      ? MainColors.warningColor(context)
                                      : MainColors.errorColor(context),
                    )
                  ],
                ),
              ],
            )
                .animate(delay: (100).ms)
                .fadeIn(duration: 900.ms, delay: 300.ms)
                .move(
                  begin: const Offset(200, 0),
                  duration: 500.ms,
                ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: MainColors.backgroundColor(context),
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: MainColors.shadowColor(context)!,
                    blurRadius: 10.r,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: Column(
                children: [
                  MyCarCardComponent(
                    car: controller?.orderModel?.car,
                    isSelected: false,
                  )
                      .animate(delay: (200).ms)
                      .fadeIn(duration: 900.ms, delay: 300.ms)
                      .move(
                        begin: const Offset(200, 0),
                        duration: 500.ms,
                      ),
                  SizedBox(height: 20.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              StringsAssetsConstants.services,
                              style: TextStyles.mediumLabelTextStyle(context),
                            )
                          ],
                        )
                            .animate(delay: (250).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 15.h),
                        Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  IconsAssetsConstants.carWashIcon,
                                  width: 22.r,
                                  height: 22.r,
                                  color: MainColors.primaryColor,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    '${controller.orderModel?.washingType?.name}',
                                    style:
                                        TextStyles.mediumBodyTextStyle(context),
                                  ),
                                ),
                                Text(
                                  '${controller.orderModel?.washingType?.price?.floor()} ${StringsAssetsConstants.currency}',
                                  style: TextStyles.largeBodyTextStyle(context)
                                      .copyWith(
                                    color: MainColors.primaryColor,
                                    fontFamily: FontsFamilyAssetsConstants.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.h),
                            Divider(
                              color: MainColors.textColor(context)!
                                  .withOpacity(0.2),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${StringsAssetsConstants.totalPrice}',
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      color: MainColors.textColor(context),
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                ),
                                Text(
                                  '${controller.orderModel?.price?.floor()} ${StringsAssetsConstants.currency}',
                                  style: TextStyles.largeBodyTextStyle(context)
                                      .copyWith(
                                    color: MainColors.primaryColor,
                                    fontFamily: FontsFamilyAssetsConstants.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 40.h),
                          ],
                        )
                            .animate(delay: (300).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SvgPicture.asset(
                          LogosAssetsConstants.appLogoVector,
                        )
                            .animate(delay: (400).ms)
                            .fadeIn(duration: 900.ms, delay: 300.ms)
                            .move(
                              begin: const Offset(200, 0),
                              duration: 500.ms,
                            ),
                        SizedBox(height: 20.h),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showRatingWindow() {
    BottomSheetComponent.show(
      Get.context!,
      body: GetBuilder<ReservationDetailsController>(
          id: GetBuildersIdsConstants.ratingWindow,
          autoRemove: false,
          builder: (logic) {
            return RatingWindowComponent(
              ratingValue: logic.ratingValue,
              changeRatingValue: logic.changeRatingValue,
              loading: logic.ratingLoading,
              ratingNoteController: logic.ratingNoteController,
              onConfirm: () => logic.rating(),
            );
          }),
    );
  }
}
