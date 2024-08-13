import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';

class MainController extends GetxController {
  int selectedBottomNavIndex = 0;
  void changeSelectedBottomNavIndex(int index) {
    selectedBottomNavIndex = index;
    update([GetBuildersIdsConstants.bottomNavigationBar]);
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
