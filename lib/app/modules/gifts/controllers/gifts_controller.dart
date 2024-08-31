import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/free_washing_config_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';

class GiftsController extends GetxController {
  FreeWashingConfigModel? freeWashingConfig;

  void changeFreeWashingConfig(FreeWashingConfigModel? value) {
    freeWashingConfig = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  bool getFreeWashingConfigLoading = false;
  void changeGetFreeWashingConfigLoading(bool value) {
    getFreeWashingConfigLoading = value;
    update([GetBuildersIdsConstants.homePaymentWindow]);
  }

  void getFreeWashingConfig() {
    ConfigProvider()
        .freeWashingConfig(
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetFreeWashingConfigLoading(true),
      onFinal: () => changeGetFreeWashingConfigLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeFreeWashingConfig(value);
      }
    });
  }

  @override
  void onInit() {
    getFreeWashingConfig();
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
