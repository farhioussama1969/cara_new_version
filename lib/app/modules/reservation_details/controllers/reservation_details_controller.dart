import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/order_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/my_reservations/controllers/my_reservations_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/reservation_details/views/reservation_details_view.dart';

class ReservationDetailsController extends GetxController {
  OrderModel? orderModel;

  final TextEditingController ratingNoteController = TextEditingController();

  double? ratingValue;
  void changeRatingValue(double value) {
    ratingValue = value;
    update([GetBuildersIdsConstants.ratingWindow]);
  }

  bool ratingLoading = false;
  void changeRatingLoading(bool value) {
    ratingLoading = value;
    update([GetBuildersIdsConstants.ratingWindow]);
  }

  Future<void> rating() async {
    if (ratingLoading) return;
    await OrderProvider()
        .ratingOrder(
      orderId: orderModel?.id,
      rating: ratingValue ?? 0,
      note: ratingNoteController.text,
      onLoading: () => changeRatingLoading(true),
      onFinal: () => changeRatingLoading(false),
    )
        .then(
      (value) {
        Get.find<MyReservationsController>().refreshMyReservations();
        Get.back();
      },
    );
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      orderModel = Get.arguments['order'];
    }
    super.onInit();
  }

  @override
  void onReady() {
    if (orderModel?.status == 'Completed' && orderModel?.note == null) {
      const ReservationDetailsView().showRatingWindow();
    }
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
