part of 'splash_cubit.dart';

class SplashState extends Equatable {
  final bool isSplashTimeEnd;

  const SplashState({required this.isSplashTimeEnd});

  SplashState copyWith({bool? isSplashTimeEnd}) {
    return SplashState(
        isSplashTimeEnd: isSplashTimeEnd ?? this.isSplashTimeEnd);
  }

  @override
  List<Object?> get props => [isSplashTimeEnd];
}
