import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';

class OrderProvider {
  Future<List<WorkingTimesModel>?> getOrderHours({
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.orderHours,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      List<WorkingTimesModel> workingTimes = [];
      response?.body['data'].forEach((workingTime) {
        workingTimes.add(WorkingTimesModel.fromJson(workingTime));
      });
      return workingTimes;
    }
    return null;
  }

  Future<List<WashingTypeModel>?> getWashingTypes({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.washingTypes,
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      List<WashingTypeModel> washingTypes = [];
      response?.body['data'].forEach((workingTime) {
        washingTypes.add(WashingTypeModel.fromJson(workingTime));
      });
      return washingTypes;
    }
    return null;
  }

  Future<OrderModel?> createNewOrder({
    required double? lat,
    required double? lng,
    required int? washingTypeId,
    required int? cardId,
    required String date,
    required String time,
    required String paymentMethod,
    required int? couponId,
    required double? price,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.orders,
      requestType: HttpRequestTypes.post,
      data: {
        "lng": lng,
        "lat": lat,
        "washing_type_id": washingTypeId,
        "car_id": cardId,
        "order_date": date,
        "order_time": time,
        "payment_method": paymentMethod,
        "coupon_id": couponId,
        "price": price ?? 0,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return OrderModel.fromJson(response?.body['data']);
    }
    return null;
  }
}
