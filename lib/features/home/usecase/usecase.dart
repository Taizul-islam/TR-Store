import 'package:dartz/dartz.dart';

import 'package:task_app/core/model/product.dart';

import '../../../core/usecase/base_usecase.dart';
import '../repository/base_repository.dart';

class HomeUseCase extends BaseUseCase<List<Product>, NoParameters> {
  final BaseHomeRepository _baseHomeRepository;

  HomeUseCase(this._baseHomeRepository);

  @override
  Future<Either<String, List<Product>>> call(NoParameters parameters) {
    return _baseHomeRepository.getProducts();
  }
}
