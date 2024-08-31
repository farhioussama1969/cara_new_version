import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';

class ReservationDetailsController extends GetxController {
  OrderModel? orderModel;

  @override
  void onInit() {
    if (Get.arguments != null) {
      orderModel = Get.arguments['order'];
    }
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
