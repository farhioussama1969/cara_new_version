import 'package:get/get.dart';
import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/modules/user_controller.dart';

class WalletProvider {
  Future<double?> getWalletAmount({
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint:
          '${EndPointsConstants.wallet}/${Get.find<UserController>().user?.id}',
      requestType: HttpRequestTypes.get,
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['data']['wallet'];
    }
    return null;
  }
}
