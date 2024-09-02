import 'package:get/get.dart';

import '../controllers/send_gifts_controller.dart';

class SendGiftsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SendGiftsController>(
      () => SendGiftsController(),
    );
  }
}
