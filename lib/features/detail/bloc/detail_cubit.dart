import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:task_app/core/model/detail.dart';
import 'package:task_app/core/model/product.dart';
import 'package:task_app/features/detail/usecase/usecase.dart';
import 'package:task_app/features/home/usecase/usecase.dart';

import '../../../core/usecase/base_usecase.dart';

part 'detail_state.dart';

class DetailCubit extends Cubit<DetailState> {
  final DetailUseCase _detailUseCase;

  DetailCubit(this._detailUseCase)
      : super(DetailInitial(
            loading: false, data: ProductDetail(), errorMessage: ''));

  getProductDetail(int id) async {
    emit(state.copyWith(loading: true, errorMessage: ""));
    final result = _detailUseCase(DetailParameter(id: id));
    result.listen((event) {
      event.fold((l) {
        emit(state.copyWith(loading: false, errorMessage: l));
      }, (r) {
        emit(state.copyWith(loading: false, data: r));
      });
    });
  }
}
