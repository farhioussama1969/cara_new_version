import 'dart:convert';

import 'package:dio/dio.dart';

class HttpClient {
  var dio = Dio();

  Future<Map<String, dynamic>> post({
    required String endPoint,
    required String publishApiKey,
    required Map<String, dynamic>? bodyData,
  }) async {
    try {
      var response = await dio.post(
        endPoint,
        data: FormData.fromMap(bodyData ?? {}),
        options: Options(
          headers: {
            'Content-type': 'application/json',
            'Authorization':
                'Basic ' + base64Encode(utf8.encode(publishApiKey + ':'))
          },
        ),
      );
      return jsonDecode(response.toString());
    } on DioError catch (e) {
      return Future.error(e.response.toString());
    }
  }
}
