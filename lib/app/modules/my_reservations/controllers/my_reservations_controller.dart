import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/order_provider.dart';

class MyReservationsController extends GetxController {
  String type = 'previous';
  void changeType(String type) {
    this.type = type;
    update([GetBuildersIdsConstants.reservationListTabBar]);
    refreshMyReservations();
  }

  final ScrollController reservationListScrollController = ScrollController();

  bool getMyReservationListLoading = false;
  void changeGetMyCarsListLoading(bool newGetMyCarsListLoading) {
    getMyReservationListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.reservationList]);
  }

  PaginationModel<OrderModel>? myReservationList;
  void changeMyReservationList(PaginationModel<OrderModel>? newData,
      {bool? refresh}) {
    if (refresh == true) {
      myReservationList = null;
    } else {
      if (myReservationList?.data?.isNotEmpty == true) {
        myReservationList?.data?.addAll(newData?.data ?? []);
        myReservationList?.meta = newData?.meta;
      } else {
        myReservationList = newData;
      }
    }
    update([GetBuildersIdsConstants.reservationList]);
  }

  int myReservationCurrentPage = 1;
  void getMyReservation() {
    OrderProvider()
        .getOrdersHistoryList(
      type: type,
      page: myReservationCurrentPage,
      onLoading: () => changeGetMyCarsListLoading(true),
      onFinal: () => changeGetMyCarsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeMyReservationList(value);
        }
      },
    );
  }

  void myReservationsScrollEvent() {
    reservationListScrollController.addListener(() {
      double maxScroll =
          reservationListScrollController.position.maxScrollExtent;
      if (reservationListScrollController.offset > maxScroll * 0.8) {
        if (!getMyReservationListLoading) {
          if (myReservationCurrentPage <
              (myReservationList?.meta?.lastPage ?? 0)) {
            myReservationCurrentPage++;
            getMyReservation();
          }
        }
      }
    });
  }

  void refreshMyReservations() {
    myReservationCurrentPage = 1;
    changeMyReservationList(null, refresh: true);
    getMyReservation();
  }

  @override
  void onInit() {
    getMyReservation();
    super.onInit();
  }

  @override
  void onReady() {
    myReservationsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
