import 'package:get/get.dart';

import '../controllers/reservation_details_controller.dart';

class ReservationDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReservationDetailsController>(
      () => ReservationDetailsController(),
    );
  }
}
