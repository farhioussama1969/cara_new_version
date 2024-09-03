import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/gift_provider.dart';

import '../../../data/models/gift_model.dart';

class SendGiftsController extends GetxController {
  List<GiftModel> giftsList = [];
  void changeGiftsList(List<GiftModel> newGiftsList) {
    giftsList = newGiftsList;
    update();
  }

  bool getGiftsLoading = false;
  void changeGiftsLoading(bool newGiftsLoading) {
    getGiftsLoading = newGiftsLoading;
    update();
  }

  // Future<void> getGiftsList() async {
  //   await GiftProvider().getGiftCouponsList(page: , branchId: branchId, onLoading: onLoading, onFinal: onFinal)
  // }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
