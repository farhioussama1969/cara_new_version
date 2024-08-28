import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/order_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/washing_type_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/working_time_model.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

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
      //
      // List<String> days = [];
      // List<List<String>> times = [];
      // response?.body['data'].forEach((workingTime) {
      //   if (days.contains(workingTime['day']) == false) {
      //     days.add(workingTime['day']);
      //   }
      // });
      //
      // response?.body['data'].forEach((workingTime) {
      //   if (days.contains(workingTime['day']) == false) {
      //     days.add(workingTime['day']);
      //   }
      // });

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
    int? subscriptionId,
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
        "order_time": time.replaceAll('H', ''),
        "payment_method": paymentMethod,
        "coupon_id": couponId,
        "price": price ?? 0,
        if (subscriptionId != null) "subscription_id": subscriptionId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      if (response?.body['data'] != null) {
        return OrderModel.fromJson(response?.body['data']);
      }
    }
    return null;
  }

  Future<OrderModel?> ratingOrder({
    required int? orderId,
    required int rating,
    required String? note,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: '${EndPointsConstants.orders}/$orderId',
      requestType: HttpRequestTypes.put,
      data: {
        "rate": rating,
        "note": note ?? '/',
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return OrderModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<OrderModel?> getLastNotRatedOrder({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.getLastNotRatedOrder,
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return OrderModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<CouponModel?> applyCoupon({
    required int? branchId,
    required String couponCode,
    required int? washingTypeId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.applyCoupon,
      requestType: HttpRequestTypes.post,
      data: {
        "coupon_code": couponCode,
        "washing_type_id": washingTypeId,
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      if (response?.body['coupon_id'] != null) {
        return CouponModel.fromJson(response?.body);
      }
    }
    return null;
  }

  Future<PaginationModel<OrderModel>?> getOrdersHistoryList({
    required int page,
    required String type,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.orders,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        "page": page,
        "filter[user_id]": Get.find<UserController>().user?.id,
        "filter[$type]": true,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(response?.body, OrderModel.fromJson);
    }
    return null;
  }
}
