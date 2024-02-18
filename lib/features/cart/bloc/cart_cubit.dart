import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_app/core/extension/extensions.dart';
import 'package:task_app/core/model/db_model.dart';
import 'package:task_app/core/utils/sqflite_util.dart';

import '../../../core/constants/color_const.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit()
      : super(const CartInitial(
            loading: false,
            data: [],
            errorMessage: '',
            increment: 1,
            total: 0.0));

  getCartList() async {
    emit(state.copyWith(loading: true, errorMessage: ""));
    CartProvider.open().then((value) {
      CartProvider.getCartList().then((value) {
        emit(state.copyWith(loading: false, data: value));
        calculateTotal(value);
      });
    });
  }

  incrementalEvent() {
    var inc = state.increment;
    inc++;
    emit(state.copyWith(increment: inc));
  }

  decrementalEvent() {
    var inc = state.increment;
    if (inc >= 2) {
      inc--;
      emit(state.copyWith(increment: inc));
    }
  }

  deleteAllCart() {
    CartProvider.open().then((value) {
      CartProvider.deleteTable().then((value) {
        emit(state.copyWith(loading: false, data: []));
        calculateTotal(state.data);
      });
    });
  }

  Future deleteSingleCart(int id) async {
    await CartProvider.open().then((value) async {
      await CartProvider.delete(id).then((value) {
        state.data.removeWhere((element) => element.id == id);
        emit(state);
        getCartList();
      });
    });
  }

  Future incrementCartItemCount(BuildContext context, int index) async {
    state.data[index].quantity = state.data[index].quantity! + 1;
    await CartProvider.open().then((value) async {
      await CartProvider.update(DbProductModel(
              id: state.data[index].id ?? 0,
              title: state.data[index].title ?? "",
              content: state.data[index].content ?? "",
              thumbnail: state.data[index].thumbnail ?? "",
              price: state.data[index].price!.toDouble(),
              quantity: state.data[index].quantity,
              total: state.data[index].price!.toDouble() * 1))
          .then((value) {
        calculateTotal(state.data);
      });
    });
  }

  decrementCartItemCount(BuildContext context, int index) async {
    var count = state.data[index].quantity ?? 1;
    if (count >= 2) {
      state.data[index].quantity = state.data[index].quantity! - 1;
      await CartProvider.open().then((value) async {
        await CartProvider.update(DbProductModel(
                id: state.data[index].id ?? 0,
                title: state.data[index].title ?? "",
                content: state.data[index].content ?? "",
                thumbnail: state.data[index].thumbnail ?? "",
                price: state.data[index].price!.toDouble(),
                quantity: state.data[index].quantity,
                total: state.data[index].price!.toDouble() *
                    state.data[index].quantity!))
            .then((value) {
          calculateTotal(state.data);
        });
      });
    }
  }

  calculateTotal(List<DbProductModel> value) {
    var total = 0.0;
    for (var element in value) {
      total = total + element.quantity! * element.price!.toDouble();
    }
    emit(state.copyWith(total: total));
  }
}
