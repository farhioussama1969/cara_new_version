import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/subscription_plan_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/user_subscription_model.dart';

class SubscriptionProvider {
  Future<List<SubscriptionPlanModel>?> getSubscriptionsPlansList({
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.subscriptions,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      List<SubscriptionPlanModel> subscriptionsPlans = [];
      response?.body['data'].forEach((workingTime) {
        subscriptionsPlans.add(SubscriptionPlanModel.fromJson(workingTime));
      });
      return subscriptionsPlans;
    }
    return null;
  }

  Future<UserSubscriptionModel?> subscription({
    required int? branchId,
    required int? subscriptionId,
    required String? paymentId,
    required String? paymentMethod,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.subscriptions,
      requestType: HttpRequestTypes.post,
      data: {
        "branch_id": branchId,
        "subscription_id": subscriptionId,
        "payment_method": paymentMethod,
        "payment_id": paymentId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return UserSubscriptionModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<List<UserSubscriptionModel>?> getMySubscriptionsList({
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.mySubscriptions,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      List<UserSubscriptionModel> mySubscriptions = [];
      response?.body['data'].forEach((workingTime) {
        mySubscriptions.add(UserSubscriptionModel.fromJson(workingTime));
      });
      return mySubscriptions;
    }
    return null;
  }
}
