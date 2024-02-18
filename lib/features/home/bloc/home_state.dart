part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  final bool loading;
  final List<Product> data;
  final String errorMessage;

  const HomeState({
    required this.loading,
    required this.data,
    required this.errorMessage,
  });

  HomeState copyWith({
    bool? loading,
    List<Product>? data,
    String? errorMessage,
  });
}

class HomeInitial extends HomeState {
  const HomeInitial(
      {required super.loading,
      required super.data,
      required super.errorMessage});

  @override
  List<Object> get props => [
        loading,
        data,
        errorMessage,
      ];

  @override
  HomeState copyWith(
      {bool? loading, List<Product>? data, String? errorMessage}) {
    return HomeInitial(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
