import 'package:get/get.dart';

import '../controllers/check_location_service_controller.dart';

class CheckLocationServiceBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CheckLocationServiceController>(
      () => CheckLocationServiceController(),
    );
  }
}
