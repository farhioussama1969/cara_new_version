import 'dart:io';

import 'package:solvodev_mobile_structure/app/core/constants/end_points_constants.dart';
import 'package:solvodev_mobile_structure/app/core/constants/storage_keys_constants.dart';
import 'package:solvodev_mobile_structure/app/core/services/http_client_service.dart';
import 'package:solvodev_mobile_structure/app/core/services/local_storage_service.dart';
import 'package:solvodev_mobile_structure/app/data/models/api_response.dart';
import 'package:solvodev_mobile_structure/app/data/models/user_model.dart';

class AuthProvider{

  Future<UserModel?> signIn({
    required String phone,
    required String password,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.login,
      requestType: HttpRequestTypes.post,
      data: {
        "phone": phone,
        "password": password,
        "device_name": Platform.isAndroid ? 'Android': 'IOS',
        "token_device":(await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string)) ?? 'no Token',
      },
      onSuccess: (response) async {
        if (response.body['token'] != null) {
          await LocalStorageService.saveData(
              key: StorageKeysConstants.serverApiToken, value: response.body['token'], type: DataTypes.string);
        }
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return UserModel.fromJson(response?.body['user']);
    }
    return null;
  }



  Future<UserModel?> signUp({
    required String username,
    required String phone,
    required String password,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.register,
      requestType: HttpRequestTypes.post,
      data: {
        "username": username,
        "phone": phone,
        "password": password,
        "password_confirmation": password,
        "device_name": Platform.isAndroid ? 'Android': 'IOS',
        "token_device":(await LocalStorageService.loadData(key: StorageKeysConstants.fcmToken, type: DataTypes.string)) ?? 'no Token',
      },
      onSuccess: (response) async {
        if (response.body['token'] != null) {
          await LocalStorageService.saveData(
              key: StorageKeysConstants.serverApiToken, value: response.body['token'], type: DataTypes.string);
        }
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return UserModel.fromJson(response?.body['user']);
    }
    return null;
  }


  Future<bool?> checkPhone({
    required String phone,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.checkUser,
      requestType: HttpRequestTypes.post,
      data: {
        "phone": phone,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['user'] == 'Exist';
    }
    return null;
  }


  Future<bool?> resetPassword({
    required String otp,
    required String phone,
    required String password,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.resetPassword,
      requestType: HttpRequestTypes.post,
      data: {
        "code_reset": otp, "phone": phone, "password": password, "password_confirmation": password,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['success'];
    }
    return null;
  }


  Future<bool?> remindPassword({
    required String phone,
    required Function onLoading,
    required Function onFinal,
  }) async {
    ApiResponse? response = await HttpClientService.sendRequest(
      endPoint: EndPointsConstants.remindPassword,
      requestType: HttpRequestTypes.post,
      data: {
        "phone": phone,
      },
      onLoading: () => onLoading(),
      onFinal: () => onFinal(),
    );
    if (response?.body != null) {
      return response?.body['success'];
    }
    return null;
  }





}