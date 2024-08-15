import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/notification_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

class NotificationProvider {
  Future<bool?> checkingUnreadNotifications({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.checkingUnreadNotifications,
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['message'];
    }
    return null;
  }

  Future<PaginationModel<NotificationModel>?> getNotificationsList({
    required int page,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.notifications,
      queryParameters: {
        'filter[user_id]': Get.find<UserController>().user?.id,
        'page': page,
      },
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(
          response?.body, NotificationModel.fromJson);
    }
    return null;
  }
}
