import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(const SplashState(isSplashTimeEnd: false)) {
    Future.delayed(const Duration(seconds: 2)).then((value) {
      emit(state.copyWith(isSplashTimeEnd: true));
    });
  }
}
