import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/config_provider.dart';

class AboutController extends GetxController {
  bool getAboutLoading = false;
  void changeAboutLoading(bool value) {
    getAboutLoading = value;
    update([GetBuildersIdsConstants.aboutBody]);
  }

  String about = '';
  void changeAbout(String value) {
    about = value;
    update([GetBuildersIdsConstants.aboutBody]);
  }

  Future<void> getAbout() async {
    await ConfigProvider()
        .about(
            onLoading: () => changeAboutLoading(true),
            onFinal: () => changeAboutLoading(false))
        .then((value) {
      if (value != null) {
        changeAbout(value);
      }
    });
  }

  @override
  void onInit() {
    getAbout();
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
