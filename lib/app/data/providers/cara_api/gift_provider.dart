import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_coupon_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/gift_model.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

import '../../models/pagination_model.dart';

class GiftProvider {
  Future<PaginationModel<GiftModel>?> getGiftsList({
    required int page,
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.gifts,
      queryParameters: {
        'page': page,
        'branch_id': branchId,
      },
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(response?.body, GiftModel.fromJson);
    }
    return null;
  }

  Future<PaginationModel<GiftCouponModel>?> getGiftCouponsList({
    required int page,
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.giftCoupons,
      queryParameters: {
        'page': page,
        'branch_id': branchId,
      },
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(response?.body, GiftCouponModel.fromJson);
    }
    return null;
  }

  Future<GiftCouponModel?> buyGift({
    bool? isWithApplePay,
    required int? giftId,
    required String? title,
    required String? paymentId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: isWithApplePay == true
          ? EndPointsConstants.buyGiftWithApplePay
          : EndPointsConstants.giftCoupons,
      queryParameters: {
        "gift_id": giftId,
        "title": title,
        "payment_method": isWithApplePay == true ? "Apple pay" : "Wallet",
        "payment_id": paymentId,
      },
      requestType: HttpRequestTypes.post,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return GiftCouponModel.fromJson(response?.body['data']);
    }
    return null;
  }
}
