import 'package:get/get.dart';

import '../controllers/remind_password_controller.dart';

class RemindPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RemindPasswordController>(
      () => RemindPasswordController(),
    );
  }
}
