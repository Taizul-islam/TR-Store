import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<Response> get(
      {required String api, dynamic data, dynamic option}) async {
    var response = await _dio.get(api, data: data);
    return response;
  }

}
