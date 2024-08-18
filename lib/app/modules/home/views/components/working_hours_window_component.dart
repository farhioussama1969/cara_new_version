import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/buttons/icon_button_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/working_hour_day_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/working_hour_time_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/core/utils/relative_date_util.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';

class WorkingHoursWindowComponent extends StatelessWidget {
  const WorkingHoursWindowComponent(
      {super.key,
      required this.loading,
      required this.daysList,
      required this.timesList,
      required this.selectedDay,
      this.selectedTime,
      required this.onDaySelected,
      required this.onTimeSelected});

  final List<String> daysList;
  final List<TimeModel> timesList;
  final String selectedDay;
  final String? selectedTime;
  final Function(String) onDaySelected;
  final Function(TimeModel) onTimeSelected;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsetsDirectional.only(top: 15.h),
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
                    StringsAssetsConstants.setDate,
                    style: TextStyles.mediumLabelTextStyle(context),
                  ),
                ),
                SizedBox(height: 15.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: loading
                        ? Padding(
                            padding: EdgeInsetsDirectional.only(
                                top: 10.h, bottom: 50.h),
                            child: const Center(
                              child: LoadingComponent(),
                            ),
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: [
                                    Text(
                                      StringsAssetsConstants.theDate,
                                      style: TextStyles.mediumLabelTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: [
                                    Text(
                                      '${RelativeDateUtil.numToMonth(DateTime.now().month)}',
                                      style: TextStyles.largeBodyTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              SizedBox(
                                height: 100.h,
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        onDaySelected(daysList[index]);
                                      },
                                      child: WorkingHourDayCardComponent(
                                        day: daysList[index],
                                        isSelected:
                                            selectedDay == daysList[index],
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                  itemCount: daysList.length,
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.w),
                                child: Row(
                                  children: [
                                    Text(
                                      StringsAssetsConstants.theTime,
                                      style: TextStyles.mediumLabelTextStyle(
                                          context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 5.h),
                              SizedBox(
                                height: 100.h,
                                child: ListView.separated(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20.w, vertical: 10.h),
                                  physics: const BouncingScrollPhysics(),
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        onDaySelected(daysList[index]);
                                      },
                                      child: WorkingHourTimeCardComponent(
                                        time: timesList[index],
                                        isSelected: selectedTime ==
                                            timesList[index].value,
                                      ),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      width: 10.w,
                                    );
                                  },
                                  itemCount: daysList.length,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                  ),
                ),
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
