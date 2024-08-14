import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/modules/gifts/controllers/gifts_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/my_account/controllers/my_account_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/my_cars/controllers/my_cars_controller.dart';
import 'package:solvodev_mobile_structure/app/modules/my_reservations/controllers/my_reservations_controller.dart';

import '../controllers/main_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );

    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<MyCarsController>(
      () => MyCarsController(),
    );
    Get.lazyPut<GiftsController>(
      () => GiftsController(),
    );
    Get.lazyPut<MyReservationsController>(
      () => MyReservationsController(),
    );
    Get.lazyPut<MyAccountController>(
      () => MyAccountController(),
    );
  }
}
