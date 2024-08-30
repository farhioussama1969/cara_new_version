import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/reservation_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

import '../controllers/my_reservations_controller.dart';

class MyReservationsView extends GetView<MyReservationsController> {
  const MyReservationsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: false,
        prefixWidget: Text(
          StringsAssetsConstants.myReservations,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(
            const Duration(milliseconds: 1500),
            () => controller.refreshMyReservations()),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: Column(
            children: [
              SizedBox(
                height: 50.h,
                child: GetBuilder<MyReservationsController>(
                    id: GetBuildersIdsConstants.reservationListTabBar,
                    builder: (logic) {
                      return CustomSlidingSegmentedControl<int>(
                        initialValue: 1,
                        fixedWidth: 0.35.sw,
                        //height: 40.h,
                        children: {
                          1: Text(StringsAssetsConstants.previousOrders,
                              style: TextStyles.largeBodyTextStyle(context)
                                  .copyWith(
                                color: logic.type == 'previous'
                                    ? MainColors.whiteColor
                                    : MainColors.textColor(context),
                              )),
                          2: Text(
                            StringsAssetsConstants.nextOrders,
                            style:
                                TextStyles.largeBodyTextStyle(context).copyWith(
                              color: logic.type == 'next'
                                  ? MainColors.whiteColor
                                  : MainColors.textColor(context),
                            ),
                          ),
                        },
                        decoration: BoxDecoration(
                          color: MainColors.inputColor(context),
                          borderRadius: BorderRadius.circular(1000.r),
                        ),
                        innerPadding: EdgeInsets.zero,
                        thumbDecoration: BoxDecoration(
                          color: MainColors.primaryColor,
                          borderRadius: BorderRadius.circular(1000.r),
                          boxShadow: [
                            BoxShadow(
                              color: MainColors.shadowColor(context)!,
                              blurRadius: 4.0,
                              spreadRadius: 1.0,
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.linear,
                        onValueChanged: (v) =>
                            logic.changeType(v == 1 ? 'previous' : 'next'),
                      );
                    }),
              )
                  .animate(delay: (150).ms)
                  .fadeIn(duration: 900.ms, delay: 300.ms)
                  .shimmer(
                      blendMode: BlendMode.srcOver,
                      color:
                          MainColors.backgroundColor(context)?.withOpacity(0.3))
                  .move(
                    begin: const Offset(0, -100),
                  ),
              Expanded(
                child: GetBuilder<MyReservationsController>(
                    id: GetBuildersIdsConstants.reservationList,
                    builder: (logic) {
                      return Stack(
                        children: [
                          SingleChildScrollView(
                            physics: const BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics()),
                            controller: logic.reservationListScrollController,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(height: 10.h),
                                SizedBox(
                                  child: ((logic.myReservationList?.data
                                                  ?.isEmpty ==
                                              true) &&
                                          !logic.getMyReservationListLoading)
                                      ? Column(
                                          children: [
                                            EmptyComponent(
                                              text: StringsAssetsConstants
                                                  .emptyReservations,
                                            ),
                                            SizedBox(height: 20.h),
                                          ],
                                        )
                                      : (logic.getMyReservationListLoading &&
                                              (logic.myReservationList?.data ??
                                                          [])
                                                      .isEmpty ==
                                                  true)
                                          ? Padding(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                      top: 50.h, bottom: 50.h),
                                              child: const Center(
                                                child: LoadingComponent(),
                                              ),
                                            )
                                          : ListView.separated(
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: 20.w,
                                                end: 20.w,
                                                top: 5.h,
                                                bottom: 30.h,
                                              ),
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return GestureDetector(
                                                  onTap: () => Get.toNamed(
                                                      Routes
                                                          .RESERVATION_DETAILS,
                                                      arguments: {
                                                        'order': logic
                                                            .myReservationList
                                                            ?.data?[index]
                                                      }),
                                                  child:
                                                      ReservationCardComponent(
                                                    order: logic
                                                        .myReservationList
                                                        ?.data?[index],
                                                  ),
                                                )
                                                    .animate(
                                                        delay: (index * 50).ms)
                                                    .fadeIn(
                                                        duration: 900.ms,
                                                        delay: 300.ms)
                                                    .move(
                                                      begin:
                                                          const Offset(200, 0),
                                                      duration: 500.ms,
                                                    );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return SizedBox(height: 10.h);
                                              },
                                              itemCount: logic.myReservationList
                                                      ?.data?.length ??
                                                  0,
                                            ),
                                ),
                              ],
                            ),
                          ),
                          if (logic.getMyReservationListLoading &&
                              logic.myReservationList?.data?.isNotEmpty == true)
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional.only(bottom: 20.h),
                                  child: const Center(
                                    child: LoadingComponent(),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
