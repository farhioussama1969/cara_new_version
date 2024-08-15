import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/car_brand_model.dart';
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

  Future<PaginationModel<CarBrandModel>?> getCarsBrandsList({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.carBrands,
      requestType: HttpRequestTypes.get,
      queryParameters: {
        'perPage': 300,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return PaginationModel.fromJson(response?.body, CarBrandModel.fromJson);
    }
    return null;
  }

  Future<CarModel?> addNewCar({
    required int? brandId,
    required String model,
    required String color,
    required String numberPlate,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.cars,
      requestType: HttpRequestTypes.post,
      data: {
        "user_id": Get.find<UserController>().user?.id,
        "carBrand_id": brandId,
        "model": model,
        "color": color,
        "number_plate": numberPlate
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return CarModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<CarModel?> updateCar({
    required int? carId,
    required int? brandId,
    required String model,
    required String color,
    required String numberPlate,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: '${EndPointsConstants.cars}/$carId',
      requestType: HttpRequestTypes.put,
      data: {
        "user_id": Get.find<UserController>().user?.id,
        "carBrand_id": brandId,
        "model": model,
        "color": color,
        "number_plate": numberPlate
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return CarModel.fromJson(response?.body['data']);
    }
    return null;
  }

  Future<bool?> deleteCar({
    required int? carId,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: '${EndPointsConstants.cars}/$carId',
      requestType: HttpRequestTypes.delete,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    return response?.statusCode == 200;
  }
}
