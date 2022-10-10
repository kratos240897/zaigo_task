import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_loggy_dio/flutter_loggy_dio.dart';
import 'package:zaigo_task/data/prefs.dart';
import '../helpers/constants.dart';

class ApiService {
  var dio = Dio(BaseOptions(
    baseUrl: Constants.BASE_URL,
    contentType: 'application/json',
  ));

  ApiService() {
    addInterceptor();
  }

  void addInterceptor() {
    dio.interceptors.add(LoggyDioInterceptor());
  }

  Future<Response> getRequest(
    String endpoint,
    Map<String, dynamic> query,
  ) async {
    try {
      Response response;
      dio.options.headers.putIfAbsent(
          HttpHeaders.authorizationHeader,
          () =>
              'Bearer ${SharedPrefHelper().get(Constants.ACCESS_TOKEN_KEY) ?? ''}');
      response = await dio.get(
        endpoint,
        queryParameters: query,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }

  Future<Response> postRequest(
      String endpoint, Map<String, dynamic> query) async {
    try {
      Response response;
      response = await dio.post(
        endpoint,
        queryParameters: query,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Future.error(e);
    }
  }
}
