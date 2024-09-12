import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

class EditInformationController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();

  bool updateProfileLoading = false;
  void changeUpdateProfileLoading(bool value) {
    updateProfileLoading = value;
    update([GetBuildersIdsConstants.updateProfileButton]);
  }

  Future<void> updateProfile() async {
    if (updateProfileLoading) return;
    if (!formKey.currentState!.validate()) return;
    await AuthProvider()
        .updateProfile(
      username: usernameController.text,
      onLoading: () => changeUpdateProfileLoading(true),
      onFinal: () => changeUpdateProfileLoading(false),
    )
        .then((value) async {
      if (value != null) {
        await Get.find<UserController>().setUser(value);
        ToastComponent.showSuccessToast(Get.context!,
            text: StringsAssetsConstants.updateProfileSuccess);
      } else {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.updateProfileFailed);
      }
    });
  }

  bool deleteProfileLoading = false;
  void changeDeleteProfileLoading(bool value) {
    deleteProfileLoading = value;
    update([GetBuildersIdsConstants.deleteProfileButton]);
  }

  void deleteAccount() async {
    if (deleteProfileLoading) return;
    await AuthProvider()
        .deleteAccount(
      onLoading: () => changeDeleteProfileLoading(true),
      onFinal: () => changeDeleteProfileLoading(false),
    )
        .then((value) async {
      await Get.find<UserController>().clearUser();
      Get.offAllNamed(Routes.GET_STARTED);
    });
  }

  @override
  void onInit() {
    usernameController.text = Get.find<UserController>().user?.username ?? '';
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
