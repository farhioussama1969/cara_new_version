import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/firebase_phone_auth_service.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';
import 'package:solvodev_mobile_structure/app/routes/app_pages.dart';

class GetStartedController extends GetxController {
  int selectedTabIndex = 1;
  void changeSelectedTapIndex(int index) {
    selectedTabIndex = index;
    update([GetBuildersIdsConstants.getStartedTap]);
  }

  final GlobalKey<FormState> signInFormKey = GlobalKey();
  final GlobalKey<FormState> signUpFormKey = GlobalKey();

  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool passwordVisibility = true;
  void togglePasswordVisibility() {
    passwordVisibility = !passwordVisibility;
    update([GetBuildersIdsConstants.signInPasswordInput]);
  }

  bool signInLoading = false;
  void changeSignLoading(bool value) {
    signInLoading = value;
    update([GetBuildersIdsConstants.signInButton]);
  }

  Future<void> signIn() async {
    if (signInLoading) false;
    if (!signInFormKey.currentState!.validate()) return;
    AuthProvider()
        .signIn(
      phone: '+966${phoneNumberController.text}',
      password: passwordController.text,
      onLoading: () => changeSignLoading(true),
      onFinal: () => changeSignLoading(false),
    )
        .then(
      (value) async {
        if (value != null) {
          await Get.find<UserController>().setUser(value);
          await Get.find<UserController>().initialize(skipUpdateChecker: true);
        }
      },
    );
  }

  bool checkingUserLoading = false;
  void changeCheckingUserLoading(bool value) {
    checkingUserLoading = value;
    update([GetBuildersIdsConstants.checkingUserButton]);
  }

  Future<void> checkingUser() async {
    if (checkingUserLoading) false;
    if (!signUpFormKey.currentState!.validate()) return;
    AuthProvider()
        .checkPhone(
      phone: '+966${phoneNumberController.text}',
      onLoading: () => changeCheckingUserLoading(true),
      onFinal: () => changeCheckingUserLoading(false),
    )
        .then(
      (value) async {
        if (value == true) {
          changeSelectedTapIndex(1);
          ToastComponent.showErrorToast(Get.context!,
              text: StringsAssetsConstants.phoneNumberExist);
        } else {
          changeCheckingUserLoading(true);
          await FirebasePhoneAuthService().sendOtpToPhone(
            phone: '+966${phoneNumberController.text}',
            onSuccess: () {
              changeCheckingUserLoading(false);
              //Get.toNamed(Routes.);
            },
            onError: () {
              changeCheckingUserLoading(false);
            },
          );
        }
      },
    );
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
