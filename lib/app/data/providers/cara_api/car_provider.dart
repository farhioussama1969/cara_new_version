import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/check_service_availability_model.dart';
import 'package:solvodev_mobile_structure/app/data/models/pagination_model.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

class CarProvider {
  Future<PaginationModel<CarModel>?> getCarsList({
    required int page,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.cars,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'page': page,
        'filter[user_id]': Get.find<UserController>().user?.id,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(response?.body, CarModel.fromJson);
    }
    return null;
  }
}
