import 'package:dio/dio.dart';
import 'package:zaigo_task/data/models/lawyers_reponse.dart';
import 'package:zaigo_task/data/models/login_response.dart';
import 'package:zaigo_task/helpers/endpoints.dart';
import 'package:zaigo_task/service/api_service.dart';

class AppRepository {
  final ApiService apiService;

  AppRepository({required this.apiService});
  Future<String> login(String phone, String password) async {
    try {
      final res = await apiService.postRequest(
          Endpoints.login, {'phone_no': phone, 'password': password});
      return LoginResponse.fromJson(res.data).accessToken;
    } catch (e) {
      if (e is DioError) {
        try {
          final res = (e.response?.data) as Map;
          throw res.entries.first.value;
        } catch (e) {
          throw 'Something went wrong!';
        }
      } else {
        throw 'Something went wrong!';
      }
    }
  }

  Future<List<Data>> getLawyers() async {
    try {
      final res = await apiService.getRequest(Endpoints.lawyers, {});
      return LawyersResponse.fromJson(res.data).data;
    } catch (e) {
      if (e is DioError) {
        try {
          final res = (e.response?.data) as Map;
          throw res.entries.first.value;
        } catch (e) {
          throw 'Something went wrong!';
        }
      } else {
        throw 'Something went wrong!';
      }
    }
  }
}
