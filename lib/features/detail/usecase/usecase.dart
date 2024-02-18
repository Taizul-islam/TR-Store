import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/core/model/detail.dart';
import '../repository/base_repository.dart';

class DetailUseCase {
  final BaseDetailRepository _baseDetailRepository;

  DetailUseCase(this._baseDetailRepository);

  Stream<Either<String, ProductDetail>> call(DetailParameter parameters) {
    return _baseDetailRepository.getProductDetail(parameters);
  }
}

class DetailParameter extends Equatable {
  final int id;

  const DetailParameter({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}
