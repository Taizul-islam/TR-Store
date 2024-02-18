import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:task_app/core/model/product.dart';
import '../../../core/constants/api_const.dart';
import '../../../core/network/error_handler.dart';
import '../../../core/network/network_info.dart';
import '../../../core/api_service/api_service.dart';

import 'base_repository.dart';

class HomeRepository extends BaseHomeRepository {
  final NetworkInfo networkInfo;
  final ApiService apiService;

  HomeRepository(
    this.networkInfo,
    this.apiService,
  );

  @override
  Future<Either<String, List<Product>>> getProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final response = await apiService.get(api: productUrl);
        var data = response.data as List;
        return Right(data.map((e) => Product.fromJson(e)).toList());
      } catch (error) {
        log("message $error");
        return Left(ErrorHandler.handle(error).errorCodeKey);
      }
    } else {
      return Left(ErrorHandler.handle(noInternetConnection).errorCodeKey);
    }
  }
}
