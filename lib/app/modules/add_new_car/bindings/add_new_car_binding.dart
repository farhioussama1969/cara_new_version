import 'package:get/get.dart';

import '../controllers/add_new_car_controller.dart';

class AddNewCarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddNewCarController>(
      () => AddNewCarController(),
    );
  }
}
