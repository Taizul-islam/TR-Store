part of 'cart_cubit.dart';

abstract class CartState extends Equatable {
  final bool loading;
  final List<DbProductModel> data;
  final String errorMessage;
  final int increment;
  final double total;

  const CartState({
    required this.loading,
    required this.data,
    required this.errorMessage,
    required this.increment,
    required this.total,
  });

  CartState copyWith(
      {bool? loading,
      List<DbProductModel>? data,
      String? errorMessage,
      int? increment,
      double? total});
}

class CartInitial extends CartState {
  const CartInitial(
      {required super.loading,
      required super.data,
      required super.errorMessage,
      required super.increment,
      required super.total});

  @override
  List<Object> get props => [loading, data, errorMessage, increment, total];

  @override
  CartState copyWith(
      {bool? loading,
      List<DbProductModel>? data,
      String? errorMessage,
      int? increment,
      double? total}) {
    return CartInitial(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      increment: increment ?? this.increment,
      total: total ?? this.total,
    );
  }
}
