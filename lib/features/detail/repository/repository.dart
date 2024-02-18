import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:task_app/core/model/detail.dart';
import 'package:task_app/features/detail/usecase/usecase.dart';
import '../../../core/constants/api_const.dart';
import '../../../core/network/error_handler.dart';
import '../../../core/network/network_info.dart';
import '../../../core/api_service/api_service.dart';

import 'base_repository.dart';

class DetailRepository extends BaseDetailRepository {
  final NetworkInfo networkInfo;
  final ApiService apiService;

  DetailRepository(
    this.networkInfo,
    this.apiService,
  );

  @override
  Stream<Either<String, ProductDetail>> getProductDetail(
      DetailParameter detailParameter) async* {
    if (await networkInfo.isConnected) {
      try {
        final response =
            await apiService.get(api: "$productUrl/${detailParameter.id}");
        yield Right(ProductDetail.fromJson(response.data));
      } catch (error) {
        log("message ${error}");
        yield Left(ErrorHandler.handle(error).errorCodeKey);
      }
    } else {
      yield Left(ErrorHandler.handle(noInternetConnection).errorCodeKey);
    }
  }
}
