import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/components/pop_ups/toast_component.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/strings_assets_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/firebase_phone_auth_service.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/auth_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/get_started/views/get_started_view.dart';
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
              changeAllowedResendOtp(false);
              changeResendOtpLoading(false);
              timerController.reset();
              timerController.start();
              changeCheckingUserLoading(false);
              const GetStartedView().showOtpConfirmationWindow();
            },
            onError: () {
              changeCheckingUserLoading(false);
            },
          );
        }
      },
    );
  }

  final TextEditingController otpController = TextEditingController();

  CustomTimerController timerController = CustomTimerController();

  bool isAllowedToResendOtp = false;
  void changeAllowedResendOtp(bool value) {
    isAllowedToResendOtp = value;
    update([GetBuildersIdsConstants.signInResendOtpButton]);
  }

  bool resendOtpLoading = false;
  void changeResendOtpLoading(bool value) {
    resendOtpLoading = value;
    update([GetBuildersIdsConstants.signInResendOtpButton]);
  }

  Future<void> resendOtp() async {
    if (resendOtpLoading) return;
    changeResendOtpLoading(true);
    await FirebasePhoneAuthService().sendOtpToPhone(
        phone: '+966${phoneNumberController.text}',
        onSuccess: () {
          changeAllowedResendOtp(false);
          changeResendOtpLoading(false);
          timerController.reset();
          timerController.start();
        },
        onError: () {
          ToastComponent.showErrorToast(Get.context!,
              text: StringsAssetsConstants.anErrorOccurredWhileSendingOtpCode);
          changeResendOtpLoading(false);
        });
  }

  bool verifyOtpLoading = false;
  void changeVerifyOtpLoading(bool value) {
    verifyOtpLoading = value;
    update([GetBuildersIdsConstants.signInOtpVerificationButton]);
  }

  Future<void> verifyOtp() async {
    if (verifyOtpLoading) return;
    if (otpController.text.length != 6) {
      ToastComponent.showErrorToast(Get.context!,
          text: StringsAssetsConstants.otpInputValidationText);
      return;
    }
    changeVerifyOtpLoading(true);
    await FirebasePhoneAuthService().otpVerification(
      otp: otpController.text,
      onSuccess: (user) async {
        String? firebaseAuthToken = await user.getIdToken();
        Get.offAllNamed(Routes.SIGN_UP, arguments: {
          'firebase_auth_token': firebaseAuthToken,
          'phone_number': phoneNumberController.text,
        });
      },
      onError: () {
        ToastComponent.showErrorToast(Get.context!,
            text: StringsAssetsConstants.wrongOtp);
        otpController.clear();
        changeVerifyOtpLoading(false);
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
