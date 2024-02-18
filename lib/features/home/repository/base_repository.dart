import 'package:dartz/dartz.dart';
import 'package:task_app/core/model/product.dart';

abstract class BaseHomeRepository {
  Future<Either<String, List<Product>>> getProducts();
}
