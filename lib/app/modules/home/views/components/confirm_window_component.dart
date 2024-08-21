import 'package:flutter/cupertino.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/primary_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';

class ConfirmWindowComponent extends StatelessWidget {
  const ConfirmWindowComponent(
      {super.key,
      this.selectedDate,
      this.selectedTime,
      this.selectedCar,
      this.selectedWashingType,
      required this.onConfirm,
      required this.onChangeDate,
      required this.onChangeWashingType,
      required this.onChangeCar});

  final CarModel? selectedCar;
  final WashingTypeModel? selectedWashingType;
  final String? selectedDate;
  final String? selectedTime;
  final void Function() onConfirm;
  final Function onChangeDate;
  final Function onChangeWashingType;
  final Function onChangeCar;

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
                    StringsAssetsConstants.confirmWashingOrder,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 30.h),
                GestureDetector(
                  onTap: () => onChangeDate(),
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
                                style: TextStyles.mediumLabelTextStyle(context),
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
                                      '${RelativeDateUtil.numToDay(RelativeDateUtil.stringToDate(selectedDate).weekday)} ',
                                  style: TextStyles.largeBodyTextStyle(context),
                                  children: [
                                    TextSpan(
                                      text:
                                          '${RelativeDateUtil.stringToDate(selectedDate).day} ',
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
                                          '${RelativeDateUtil.numToMonth(RelativeDateUtil.stringToDate(selectedDate).month)} ',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
                                    ),
                                    TextSpan(
                                      text:
                                          '${RelativeDateUtil.stringToDate(selectedDate).year} ',
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
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
                                    ),
                                    TextSpan(
                                      text:
                                          '${RelativeDateUtil.changeHourFormat(selectedTime?.replaceAll('H', ''))} ',
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
                                          '${RelativeDateUtil.getAmPmFromTime(selectedTime).substring(0, 5)} ',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
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
                )
                    .animate(delay: (150).ms)
                    .fadeIn(duration: 900.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(0, -200),
                      duration: 500.ms,
                    ),
                SizedBox(height: 10.r),
                Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onChangeWashingType(),
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
                                      style: TextStyles.mediumLabelTextStyle(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${selectedWashingType?.name}',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
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
                    )
                        .animate(delay: (150).ms)
                        .fadeIn(duration: 900.ms, delay: 300.ms)
                        .move(
                          begin: const Offset(200, 0),
                          duration: 500.ms,
                        ),
                    SizedBox(width: 10.r),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => onChangeCar(),
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
                                      style: TextStyles.mediumLabelTextStyle(
                                          context),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      '${selectedCar?.brand?.name}',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
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
                    )
                        .animate(delay: (150).ms)
                        .fadeIn(duration: 900.ms, delay: 300.ms)
                        .move(
                          begin: const Offset(-200, 0),
                          duration: 500.ms,
                        ),
                  ],
                ),
                SizedBox(height: 30.h),
                PrimaryButtonComponent(
                  onTap: () => onConfirm(),
                  text: StringsAssetsConstants.confirm,
                  width: 0.7.sw,
                )
                    .animate(delay: (150).ms)
                    .fadeIn(duration: 900.ms, delay: 300.ms)
                    .move(
                      begin: const Offset(0, 200),
                      duration: 500.ms,
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
