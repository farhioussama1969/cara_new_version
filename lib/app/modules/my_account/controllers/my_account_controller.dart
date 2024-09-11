import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

class MyAccountController extends GetxController {
  bool logoutLoading = false;
  void changeLogoutLoading(bool value) {
    logoutLoading = value;
    update([GetBuildersIdsConstants.logoutConfirmationButton]);
  }

  void logout() {
    AuthProvider()
        .logout(
      onLoading: () => changeLogoutLoading(true),
      onFinal: () => changeLogoutLoading(false),
    )
        .then((value) async {
      await Get.find<UserController>().clearUser(withoutLogout: false);
      Get.offAllNamed(Routes.GET_STARTED);
    });
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
