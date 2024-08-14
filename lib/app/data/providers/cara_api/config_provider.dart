import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/check_service_availability_model.dart';

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
}
