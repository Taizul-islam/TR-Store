part of 'detail_cubit.dart';

abstract class DetailState extends Equatable {
  final bool loading;
  final ProductDetail data;
  final String errorMessage;

  const DetailState({
    required this.loading,
    required this.data,
    required this.errorMessage,
  });

  DetailState copyWith({
    bool? loading,
    ProductDetail? data,
    String? errorMessage,
  });
}

class DetailInitial extends DetailState {
  const DetailInitial(
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
  DetailState copyWith(
      {bool? loading, ProductDetail? data, String? errorMessage}) {
    return DetailInitial(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
