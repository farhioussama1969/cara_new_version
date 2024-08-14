import 'package:get/get.dart';

import '../controllers/my_cars_controller.dart';

class MyCarsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCarsController>(
      () => MyCarsController(),
    );
  }
}
