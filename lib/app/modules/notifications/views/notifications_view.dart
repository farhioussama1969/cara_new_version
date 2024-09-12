import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/animations/loading_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/cards/notification_card_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/empty_component.dart';
import 'package:solvodev_mobile_structure/app/core/components/others/header_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/styles/main_colors.dart';
import 'package:solvodev_mobile_structure/app/core/styles/text_styles.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

import '../controllers/notifications_controller.dart';

class NotificationsView extends GetView<NotificationsController> {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeaderComponent(
        isBack: true,
        actionWidget: Text(
          StringsAssetsConstants.notifications,
          style: TextStyles.largeLabelTextStyle(context),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => Future.delayed(
            const Duration(milliseconds: 1500),
            () => controller.refreshNotifications()),
        backgroundColor: MainColors.backgroundColor(context),
        color: MainColors.primaryColor,
        child: SizedBox(
          height: 1.sh,
          child: GetBuilder<NotificationsController>(
              id: GetBuildersIdsConstants.notificationsList,
              builder: (logic) {
                return Stack(
                  children: [
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      controller: logic.notificationsListScrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 10.h),
                          SizedBox(
                            child: ((logic.notificationsList?.data?.isEmpty ==
                                        true) &&
                                    !logic.getNotificationsListLoading)
                                ? Column(
                                    children: [
                                      EmptyComponent(
                                        text: StringsAssetsConstants
                                            .emptyDataText,
                                      ),
                                      SizedBox(height: 20.h),
                                    ],
                                  )
                                : (logic.getNotificationsListLoading &&
                                        (logic.notificationsList?.data ?? [])
                                                .isEmpty ==
                                            true)
                                    ? Padding(
                                        padding: EdgeInsetsDirectional.only(
                                            top: 50.h, bottom: 50.h),
                                        child: const Center(
                                          child: LoadingComponent(),
                                        ),
                                      )
                                    : Stack(
                                        children: [
                                          ListView.separated(
                                            padding: EdgeInsetsDirectional.only(
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
                                                onTap: () {
                                                  Get.toNamed(
                                                      Routes
                                                          .RESERVATION_DETAILS,
                                                      arguments: {
                                                        'order': logic
                                                            .notificationsList
                                                            ?.data?[index]
                                                            .order
                                                      });
                                                },
                                                child:
                                                    NotificationCardComponent(
                                                  notification: logic
                                                      .notificationsList
                                                      ?.data?[index],
                                                ),
                                              )
                                                  .animate(
                                                      delay: (index * 50).ms)
                                                  .fadeIn(
                                                      duration: 900.ms,
                                                      delay: 300.ms)
                                                  .move(
                                                    begin: const Offset(200, 0),
                                                    duration: 500.ms,
                                                  );
                                            },
                                            separatorBuilder: (context, index) {
                                              return SizedBox(height: 10.h);
                                            },
                                            itemCount: logic.notificationsList
                                                    ?.data?.length ??
                                                0,
                                          ),
                                        ],
                                      ),
                          ),
                        ],
                      ),
                    ),
                    if (logic.getNotificationsListLoading &&
                        logic.notificationsList?.data?.isNotEmpty == true)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.only(bottom: 20.h),
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
      ),
    );
  }
}
