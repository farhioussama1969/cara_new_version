import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/remind_password/views/remind_password_view.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

class RemindPasswordController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController phoneController = TextEditingController();

  bool sendOtpLoading = false;
  void changeSendOtpLoading(bool value) {
    sendOtpLoading = value;
    update([GetBuildersIdsConstants.resetPasswordButton]);
  }

  void sendOtp() {
    if (sendOtpLoading) return;
    if (!formKey.currentState!.validate()) return;
    AuthProvider()
        .remindPassword(
      phone: '+966${phoneController.text}',
      onLoading: () => changeSendOtpLoading(true),
      onFinal: () => changeSendOtpLoading(false),
    )
        .then((value) {
      if (value == true) {
        const RemindPasswordView().showOtpConfirmationWindow();
      }
    });
  }

  final TextEditingController otpController = TextEditingController();

  bool verifyOtpLoading = false;
  void changeVerifyOtpLoading(bool value) {
    verifyOtpLoading = value;
    update([GetBuildersIdsConstants.otpVerificationWindow]);
  }

  void verifyOtp() {
    if (verifyOtpLoading) return;
    AuthProvider()
        .checkOtp(
      otp: otpController.text,
      phone: '+966${phoneController.text}',
      onLoading: () => changeVerifyOtpLoading(true),
      onFinal: () => changeVerifyOtpLoading(false),
    )
        .then((value) {
      if (value == true) {
        Get.toNamed(Routes.RESET_PASSWORD, arguments: {
          'otp': otpController.text,
          'phone': phoneController.text
        });
      }
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
