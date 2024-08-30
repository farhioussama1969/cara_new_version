import 'package:get/get.dart';

import '../controllers/edit_car_controller.dart';

class EditCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditCarController>(
      () => EditCarController(),
    );
  }
}
