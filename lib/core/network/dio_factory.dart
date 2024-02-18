
import 'package:dio/dio.dart';

import '../constants/api_const.dart';


class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    Map<String, String> headers = {
      "Accept":"application/json",
      "Content-Type":"application/json",
    };

    dio.options = BaseOptions(
      baseUrl: baseUrl,
      headers: headers,
    );
    return dio;
  }
}
