import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';

class ReservationCardComponent extends StatelessWidget {
  const ReservationCardComponent({super.key, required this.order});

  final OrderModel? order;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: MainColors.backgroundColor(context),
        boxShadow: [
          BoxShadow(
            color: MainColors.shadowColor(context)!,
            blurRadius: 10.r,
            offset: const Offset(0, 0),
          ),
        ],
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.r),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: MainColors.backgroundColor(context),
                    boxShadow: [
                      BoxShadow(
                        color: MainColors.shadowColor(context)!,
                        blurRadius: 15.r,
                        offset: Offset(0, 0),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset(
                            IconsAssetsConstants.calendarIcon,
                            width: 25.r,
                            height: 25.r,
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Text(
                              StringsAssetsConstants.washingDate,
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: MainColors.primaryColor,
                                fontFamily: FontsFamilyAssetsConstants.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text:
                                    '${RelativeDateUtil.numToDay(DateTime.parse(order?.date ?? '').weekday)} ',
                                style: TextStyles.largeBodyTextStyle(context),
                                children: [
                                  TextSpan(
                                    text:
                                        '${DateTime.parse(order?.date ?? '').day} ',
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
                                        '${RelativeDateUtil.numToMonth(DateTime.parse(order?.date ?? '').month)} ',
                                    style:
                                        TextStyles.largeBodyTextStyle(context),
                                  ),
                                  TextSpan(
                                    text:
                                        '${DateTime.parse(order?.date ?? '').year} ',
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      color: MainColors.primaryColor,
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' | ',
                                    style:
                                        TextStyles.largeBodyTextStyle(context),
                                  ),
                                  TextSpan(
                                    text:
                                        '${RelativeDateUtil.changeHourFormat(order?.time?.replaceAll('H', ''))} ',
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
                                        '${RelativeDateUtil.getAmPmFromTime(order?.time).substring(0, 5)} ',
                                    style:
                                        TextStyles.largeBodyTextStyle(context),
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
                SizedBox(height: 10.r),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MainColors.backgroundColor(context),
                          boxShadow: [
                            BoxShadow(
                              color: MainColors.shadowColor(context)!,
                              blurRadius: 15.r,
                              offset: Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  IconsAssetsConstants.carWashIcon,
                                  width: 25.r,
                                  height: 25.r,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    StringsAssetsConstants.washingType,
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      color: MainColors.primaryColor,
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${order?.washingType?.name}',
                                    style:
                                        TextStyles.largeBodyTextStyle(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 10.r),
                    Expanded(
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: MainColors.backgroundColor(context),
                          boxShadow: [
                            BoxShadow(
                              color: MainColors.shadowColor(context)!,
                              blurRadius: 15.r,
                              offset: Offset(0, 0),
                            ),
                          ],
                          borderRadius: BorderRadius.circular(15.r),
                        ),
                        padding: EdgeInsets.symmetric(
                            horizontal: 20.w, vertical: 15.h),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  IconsAssetsConstants.myCarsEnabledIcon,
                                  width: 22.r,
                                  height: 22.r,
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  child: Text(
                                    StringsAssetsConstants.carBrand,
                                    style:
                                        TextStyles.largeBodyTextStyle(context)
                                            .copyWith(
                                      color: MainColors.primaryColor,
                                      fontFamily:
                                          FontsFamilyAssetsConstants.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    '${order?.car?.brand?.name}',
                                    style:
                                        TextStyles.largeBodyTextStyle(context),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
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
          Container(
            decoration: BoxDecoration(
              color: order?.status == "Accepted"
                  ? MainColors.successColor(context)
                  : order?.status == "Completed"
                      ? MainColors.successColor(context)
                      : order?.status == "In way"
                          ? MainColors.warningColor(context)
                          : MainColors.errorColor(context),
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(12.r)),
            ),
            padding: EdgeInsets.symmetric(vertical: 15.h),
            child: Center(
              child: Text(
                order?.status == "Accepted"
                    ? StringsAssetsConstants.acceptedOrder
                    : order?.status == "Completed"
                        ? StringsAssetsConstants.orderCompleted
                        : order?.status == "In way"
                            ? StringsAssetsConstants.onTheWay
                            : StringsAssetsConstants.orderCanceled,
                style: TextStyles.largeBodyTextStyle(context).copyWith(
                  color: MainColors.whiteColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
