import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';

class HomeController extends GetxController {
  bool checkingServiceAvailabilityLoading = false;
  void changeCheckingServiceAvailabilityLoading(bool value) {
    checkingServiceAvailabilityLoading = value;
    update([GetBuildersIdsConstants.honeFloatingButton]);
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
