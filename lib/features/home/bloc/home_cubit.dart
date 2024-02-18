
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/model/product.dart';
import 'package:task_app/features/home/usecase/usecase.dart';

import '../../../core/usecase/base_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeUseCase _homeUseCase;

  HomeCubit(this._homeUseCase)
      : super(const HomeInitial(loading: false, data: [], errorMessage: '')) {
    getProductList();
  }

  getProductList() async {
    emit(state.copyWith(loading: true, errorMessage: ""));
    final result = await _homeUseCase(const NoParameters());
    result.fold((l) {
      emit(state.copyWith(errorMessage: l, loading: false));
    }, (r) async {
      emit(state.copyWith(data: r, loading: false));
    });
  }
}
