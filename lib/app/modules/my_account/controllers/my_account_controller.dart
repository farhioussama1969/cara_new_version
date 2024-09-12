import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';
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

  String whatsAppNumber = '';
  void setWhatsAppNumber(String number) {
    whatsAppNumber = number;
  }

  void getWhatsAppNumber() {
    ConfigProvider()
        .whatsapp(
            branchId: Get.find<HomeController>()
                .checkServiceAvailabilityResponse
                ?.branch
                ?.id,
            onLoading: () {},
            onFinal: () {})
        .then((value) {
      if (value != null) {
        setWhatsAppNumber(value);
      }
    });
  }

  @override
  void onInit() {
    getWhatsAppNumber();
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
