import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/check_service_availability_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/free_washing_config_model.dart';

class ConfigProvider {
  Future<CheckServiceAvailabilityModel?> checkServiceAvailability({
    required double? lat,
    required double? lng,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.checkCityService,
      requestType: HttpRequestTypes.post,
      data: {
        'lat': lat,
        'lng': lng,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return CheckServiceAvailabilityModel.fromJson(response?.body);
    }
    return null;
  }

  Future<FreeWashingConfigModel?> freeWashingConfig({
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.freeWashingConfig,
      requestType: HttpRequestTypes.get,
      data: {
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return FreeWashingConfigModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<String?> policyAndPrivacy({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.policyAndPrivacy,
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['privacy_policy'];
    }
    return null;
  }

  Future<String?> about({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.about,
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['about_app'];
    }
    return null;
  }

  Future<String?> whatsapp({
    required int? branchId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.whatsapp,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'branch_id': branchId,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['whats_number'];
    }
    return null;
  }
}
