import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

class SignUpController extends GetxController {
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();

  final FocusNode fullNameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();

  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool passwordVisibility = true;
  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update([GetBuildersIdsConstants.signUpPasswordInput]);
  }

  bool confirmPasswordVisibility = true;
  void toggleConfirmPasswordVisibility() {
    confirmPasswordVisibility = !confirmPasswordVisibility;
    update([GetBuildersIdsConstants.signUpConfirmPasswordInput]);
  }

  bool signUpLoading = false;
  void changeSignUpLoading(bool value) {
    signUpLoading = value;
    update([GetBuildersIdsConstants.signUpButton]);
  }

  void signUp() {
    if (signUpLoading) return;
    AuthProvider()
        .signUp(
      username: fullNameController.text,
      phone: '+966${Get.arguments['phone_number']}',
      password: passwordController.text,
      onLoading: () => changeSignUpLoading(true),
      onFinal: () => changeSignUpLoading(false),
    )
        .then((value) async {
      if (value != null) {
        await Get.find<UserController>().setUser(value);
        await Get.find<UserController>().initialize(skipUpdateChecker: true);
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
