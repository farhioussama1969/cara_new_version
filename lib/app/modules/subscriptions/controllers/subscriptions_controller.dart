import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/get_builders_ids_constants.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';
import 'package:solvodev_mobile_structure/app/data/providers/cara_api/subscription_provider.dart';
import 'package:solvodev_mobile_structure/app/modules/home/controllers/home_controller.dart';

class SubscriptionsController extends GetxController {
  List<SubscriptionPlanModel> subscriptions = [];
  void changeSubscriptions(List<SubscriptionPlanModel> newWashingTypes) {
    subscriptions = newWashingTypes;
    update([GetBuildersIdsConstants.subscriptionsList]);
  }

  bool getSubscriptionsLoading = false;
  void changeGetSubscriptionsLoading(bool newGetWashingTypesLoading) {
    getSubscriptionsLoading = newGetWashingTypesLoading;
    update([GetBuildersIdsConstants.subscriptionsList]);
  }

  void getSubscriptions() {
    changeSubscriptions([]);
    SubscriptionProvider()
        .getSubscriptionsPlansList(
      branchId: Get.find<HomeController>()
          .checkServiceAvailabilityResponse
          ?.branch
          ?.id,
      onLoading: () => changeGetSubscriptionsLoading(true),
      onFinal: () => changeGetSubscriptionsLoading(false),
    )
        .then((value) {
      if (value != null) {
        changeSubscriptions(value);
      }
    });
  }

  @override
  void onInit() {
    getSubscriptions();
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
