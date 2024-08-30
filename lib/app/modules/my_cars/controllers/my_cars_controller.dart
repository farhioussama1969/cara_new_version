import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/car_provider.dart';

class MyCarsController extends GetxController {
  final ScrollController myCarsListScrollController = ScrollController();

  bool getMyCarsListLoading = false;
  void changeGetMyCarsListLoading(bool newGetMyCarsListLoading) {
    getMyCarsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.myCarsList]);
  }

  PaginationModel<CarModel>? myCarsList;
  void changeMyCarsList(PaginationModel<CarModel>? newData, {bool? refresh}) {
    if (refresh == true) {
      myCarsList = null;
    } else {
      if (myCarsList?.data?.isNotEmpty == true) {
        myCarsList?.data?.addAll(newData?.data ?? []);
        myCarsList?.meta = newData?.meta;
      } else {
        myCarsList = newData;
      }
    }
    update([GetBuildersIdsConstants.myCarsList]);
  }

  int myCarsCurrentPage = 1;
  void getMyCars() {
    CarProvider()
        .getCarsList(
      page: myCarsCurrentPage,
      onLoading: () => changeGetMyCarsListLoading(true),
      onFinal: () => changeGetMyCarsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeMyCarsList(value);
        }
      },
    );
  }

  void myCarsScrollEvent() {
    myCarsListScrollController.addListener(() {
      double maxScroll = myCarsListScrollController.position.maxScrollExtent;
      if (myCarsListScrollController.offset > maxScroll * 0.8) {
        if (!getMyCarsListLoading) {
          if (myCarsCurrentPage < (myCarsList?.meta?.lastPage ?? 0)) {
            myCarsCurrentPage++;
            getMyCars();
          }
        }
      }
    });
  }

  void refreshMyCars() {
    myCarsCurrentPage = 1;
    changeMyCarsList(null, refresh: true);
    getMyCars();
  }

  @override
  void onInit() {
    getMyCars();
    super.onInit();
  }

  @override
  void onReady() {
    myCarsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
