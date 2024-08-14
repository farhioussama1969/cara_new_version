import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/fonts_family_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/icons_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: EdgeInsets.all(10.r),
        child: Container(
          height: 100.r,
          width: 100.r,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1000.r),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(1000.r),
            child: FloatingActionButton(
              backgroundColor: MainColors.primaryColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    IconsAssetsConstants.caraIcon,
                    width: 38.r,
                    height: 38.r,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  GetBuilder<HomeController>(
                      id: GetBuildersIdsConstants.honeFloatingButton,
                      builder: (logic) {
                        return Center(
                          child: !logic.checkingServiceAvailabilityLoading
                              ? Text(
                                  StringsAssetsConstants.orderWash,
                                  style: TextStyles.smallBodyTextStyle(context)
                                      .copyWith(
                                    color: MainColors.whiteColor,
                                  ),
                                )
                              : LoadingComponent(
                                  color: MainColors.whiteColor,
                                ),
                        );
                      }),
                ],
              ),
              onPressed: () {
                //controller.washingOrder();
              },
            ),
          ),
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterFloat,
      body: Stack(
        children: [
          Container(
            color: MainColors.errorColor(context),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                children: [
                  BottomAppBar(
                    color: MainColors.backgroundColor(context),
                    elevation: 0,
                    shape: const CircularNotchedRectangle(),
                    notchMargin: 5.r,
                    height: 40.h,
                    child: Container(),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // controller.setWishType();
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                IconsAssetsConstants.carWashIcon,
                                // controller.finalWishTyeId.value == ''
                                //     ? 'assets/icons/car_wash_icon.svg'
                                //     : 'assets/icons/checked.svg',
                                width: 25.r,
                                height: 25.r,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                StringsAssetsConstants.washingType,
                                style: TextStyles.largeBodyTextStyle(context)
                                    .copyWith(
                                  fontFamily: FontsFamilyAssetsConstants.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // controller.fetchOrdersPerHourList();
                            // setDateWindow();
                            // controller.setDate();
                          },
                          child: Row(
                            children: [
                              Text(
                                StringsAssetsConstants.setDate,
                                style: TextStyles.largeBodyTextStyle(context)
                                    .copyWith(
                                  fontFamily: FontsFamilyAssetsConstants.bold,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              SvgPicture.asset(
                                IconsAssetsConstants.calendarIcon,
                                // controller.finalSelectedTime.value == ''
                                //     ? 'assets/icons/calendar_icon.svg'
                                //     : 'assets/icons/checked.svg',
                                width: 25.r,
                                height: 25.r,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
