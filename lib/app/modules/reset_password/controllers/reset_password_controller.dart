import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

import '../../../core/constants/get_builders_ids_constants.dart';

class ResetPasswordController extends GetxController {
  String? phone;
  String? otp;

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;
  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update([GetBuildersIdsConstants.signInPasswordInput]);
  }

  bool changePasswordLoading = false;
  void changeChangePasswordLoading(bool value) {
    changePasswordLoading = value;
    update([GetBuildersIdsConstants.resetPasswordButton]);
  }

  void changePassword() {
    if (changePasswordLoading) return;
    if (!resetPasswordFormKey.currentState!.validate()) return;
    AuthProvider()
        .resetPassword(
      phone: '+966$phone',
      otp: otp ?? '',
      password: passwordController.text,
      onLoading: () => changeChangePasswordLoading(true),
      onFinal: () => changeChangePasswordLoading(false),
    )
        .then((value) {
      if (value == true) {
        ToastComponent.showSuccessToast(Get.context!,
            text: StringsAssetsConstants.changePasswordSuccess);
        Get.offAllNamed(Routes.GET_STARTED);
      }
    });
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      phone = Get.arguments['phone'];
      otp = Get.arguments['otp'];
    }
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
