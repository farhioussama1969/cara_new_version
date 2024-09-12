import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/notification_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/notification_provider.dart';

class NotificationsController extends GetxController {
  final ScrollController notificationsListScrollController = ScrollController();

  bool getNotificationsListLoading = false;
  void changeGetNotificationsListLoading(bool newGetMyCarsListLoading) {
    getNotificationsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.notificationsList]);
  }

  PaginationModel<NotificationModel>? notificationsList;
  void changeNotificationsList(PaginationModel<NotificationModel>? newData,
      {bool? refresh}) {
    if (refresh == true) {
      notificationsList = null;
    } else {
      if (notificationsList?.data?.isNotEmpty == true) {
        notificationsList?.data?.addAll(newData?.data ?? []);
        notificationsList?.meta = newData?.meta;
      } else {
        notificationsList = newData;
      }
    }
    update([GetBuildersIdsConstants.notificationsList]);
  }

  int notificationsCurrentPage = 1;
  void getNotifications() {
    NotificationProvider()
        .getNotificationsList(
      page: notificationsCurrentPage,
      onLoading: () => changeGetNotificationsListLoading(true),
      onFinal: () => changeGetNotificationsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeNotificationsList(value);
        }
      },
    );
  }

  void notificationsScrollEvent() {
    notificationsListScrollController.addListener(() {
      double maxScroll =
          notificationsListScrollController.position.maxScrollExtent;
      if (notificationsListScrollController.offset > maxScroll * 0.8) {
        if (!getNotificationsListLoading) {
          if (notificationsCurrentPage <
              (notificationsList?.meta?.lastPage ?? 0)) {
            notificationsCurrentPage++;
            getNotifications();
          }
        }
      }
    });
  }

  void refreshNotifications() {
    notificationsCurrentPage = 1;
    changeNotificationsList(null, refresh: true);
    getNotifications();
  }

  @override
  void onInit() {
    getNotifications();

    super.onInit();
  }

  @override
  void onReady() {
    notificationsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
