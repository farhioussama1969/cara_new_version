import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';

class PolicyPrivacyController extends GetxController {
  bool getPolicyLoading = false;
  void changePolicyLoading(bool value) {
    getPolicyLoading = value;
    update([GetBuildersIdsConstants.policyBody]);
  }

  String policy = '';
  void changePolicy(String value) {
    policy = value;
    update([GetBuildersIdsConstants.policyBody]);
  }

  Future<void> getPolicy() async {
    await ConfigProvider()
        .policyAndPrivacy(
            onLoading: () => changePolicyLoading(true),
            onFinal: () => changePolicyLoading(false))
        .then((value) {
      if (value != null) {
        changePolicy(value);
      }
    });
  }

  @override
  void onInit() {
    getPolicy();
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
