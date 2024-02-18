import 'package:dartz/dartz.dart';
import 'package:task_app/core/model/detail.dart';

import '../usecase/usecase.dart';

abstract class BaseDetailRepository {
  Stream<Either<String, ProductDetail>> getProductDetail(
      DetailParameter detailParameter);
}
