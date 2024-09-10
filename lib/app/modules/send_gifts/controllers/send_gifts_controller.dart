import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/gift_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';

import '../../../data/models/gift_model.dart';

class SendGiftsController extends GetxController {
  int giftsCurrentTabIndex = 1;
  void changeGiftsCurrentPage(int newGiftsCurrentPage) {
    giftsCurrentTabIndex = newGiftsCurrentPage;
    update([
      GetBuildersIdsConstants.sendGiftsTopBar,
      GetBuildersIdsConstants.sendGiftsList
    ]);
  }

  final ScrollController giftsListScrollController = ScrollController();

  bool getGiftsListLoading = false;
  void changeGetGiftsListLoading(bool newGetMyCarsListLoading) {
    getGiftsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  PaginationModel<GiftModel>? giftsList;
  void changeGiftsList(PaginationModel<GiftModel>? newData, {bool? refresh}) {
    if (refresh == true) {
      giftsList = null;
    } else {
      if (giftsList?.data?.isNotEmpty == true) {
        giftsList?.data?.addAll(newData?.data ?? []);
        giftsList?.meta = newData?.meta;
      } else {
        giftsList = newData;
      }
    }
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  int giftsCurrentPage = 1;
  void getGifts() {
    GiftProvider()
        .getGiftsList(
      page: giftsCurrentPage,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetGiftsListLoading(true),
      onFinal: () => changeGetGiftsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeGiftsList(value);
        }
      },
    );
  }

  void giftsScrollEvent() {
    giftsListScrollController.addListener(() {
      double maxScroll = giftsListScrollController.position.maxScrollExtent;
      if (giftsListScrollController.offset > maxScroll * 0.8) {
        if (!getGiftsListLoading) {
          if (giftsCurrentPage < (giftsList?.meta?.lastPage ?? 0)) {
            giftsCurrentPage++;
            getGifts();
          }
        }
      }
    });
  }

  void refreshGifts() {
    giftsCurrentPage = 1;
    changeGiftsList(null, refresh: true);
    getGifts();
  }

  final ScrollController oldGiftsListScrollController = ScrollController();

  bool getOldGiftsListLoading = false;
  void changeGetOldGiftsListLoading(bool newGetMyCarsListLoading) {
    getOldGiftsListLoading = newGetMyCarsListLoading;
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  PaginationModel<GiftCouponModel>? oldGiftsList;
  void changeOldGiftsList(PaginationModel<GiftCouponModel>? newData,
      {bool? refresh}) {
    if (refresh == true) {
      oldGiftsList = null;
    } else {
      if (oldGiftsList?.data?.isNotEmpty == true) {
        oldGiftsList?.data?.addAll(newData?.data ?? []);
        oldGiftsList?.meta = newData?.meta;
      } else {
        oldGiftsList = newData;
      }
    }
    update([GetBuildersIdsConstants.sendGiftsList]);
  }

  int oldGiftsCurrentPage = 1;
  void getOldGifts() {
    GiftProvider()
        .getGiftCouponsList(
      page: oldGiftsCurrentPage,
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetOldGiftsListLoading(true),
      onFinal: () => changeGetOldGiftsListLoading(false),
    )
        .then(
      (value) {
        if (value != null) {
          changeOldGiftsList(value);
        }
      },
    );
  }

  void oldGiftsScrollEvent() {
    oldGiftsListScrollController.addListener(() {
      double maxScroll = oldGiftsListScrollController.position.maxScrollExtent;
      if (oldGiftsListScrollController.offset > maxScroll * 0.8) {
        if (!getOldGiftsListLoading) {
          if (oldGiftsCurrentPage < (oldGiftsList?.meta?.lastPage ?? 0)) {
            oldGiftsCurrentPage++;
            getOldGifts();
          }
        }
      }
    });
  }

  void refreshOldGifts() {
    oldGiftsCurrentPage = 1;
    changeOldGiftsList(null, refresh: true);
    getOldGifts();
  }

  @override
  void onInit() {
    getGifts();
    getOldGifts();
    super.onInit();
  }

  @override
  void onReady() {
    giftsScrollEvent();
    oldGiftsScrollEvent();
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
