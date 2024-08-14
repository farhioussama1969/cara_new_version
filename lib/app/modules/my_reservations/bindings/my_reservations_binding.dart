import 'package:get/get.dart';

import '../controllers/my_reservations_controller.dart';

class MyReservationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyReservationsController>(
      () => MyReservationsController(),
    );
  }
}
