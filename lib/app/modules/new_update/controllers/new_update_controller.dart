import 'dart:io';

import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/data/models/app_version_checker_model.dart';
import 'package:solvodev_mobile_structure/app/modules/config_controller.dart';

class NewUpdateController extends GetxController {
  AppVersionCheckerModel? versionData;

  @override
  void onInit() {
    if (Get.arguments != null) {
      if (Get.arguments['versionData'] != null) {
        versionData = Get.arguments['versionData'];
      }
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
