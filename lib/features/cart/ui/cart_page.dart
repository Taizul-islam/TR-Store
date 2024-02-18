import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_app/core/constants/color_const.dart';
import 'package:task_app/core/extension/extensions.dart';
import 'package:task_app/core/utils/height_util.dart';
import 'package:task_app/core/utils/width_util.dart';
import 'package:task_app/features/cart/bloc/cart_cubit.dart';
import 'package:task_app/widgets/failure_widget.dart';

import '../../../core/constants/localization_const.dart';
import '../../detail/bloc/detail_cubit.dart';
import '../../detail/ui/detail_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: AppBar(
        backgroundColor: g1,
        title: cart.apply(
            color: txtColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Text(
                                "Are you sure?\n You want to remove all saved cart items",
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              height(20),
                              Row(
                                children: [
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  )),
                                  width(20),
                                  Expanded(
                                      child: ElevatedButton(
                                    onPressed: () {
                                      context.read<CartCubit>().deleteAllCart();
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes"),
                                  ))
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: const Icon(Icons.delete_forever))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state.loading) {}
                  if (state.errorMessage.isNotEmpty) {
                    return FailureWidget(
                      error: state.errorMessage,
                      isExitButtonShow: false,
                    );
                  }
                  if (state.data.isEmpty) {
                    return const Center(
                      child: Text(
                        "Empty Cart",
                        style: TextStyle(fontSize: 40),
                      ),
                    );
                  }
                  return ListView.builder(
                      itemCount: state.data.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            context.read<DetailCubit>().getProductDetail(state.data[index].id ?? 0);
                            Navigator.of(context).push(PageTransition(
                                child:  DetailPage(id: state.data[index].id ?? 0,),
                                type: PageTransitionType.rightToLeft));
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.only(bottom: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white),
                            child: Row(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                      state.data[index].thumbnail ?? "",
                                      height: 100,
                                      width: 100,
                                    )),
                                width(10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Text(
                                        state.data[index].title.toString(),
                                        style: const TextStyle(fontSize: 13),
                                      ),
                                      Text(
                                        state.data[index].content.toString(),
                                        style: const TextStyle(fontSize: 11),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      height(5),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                                width: 40,
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 6),
                                                decoration: BoxDecoration(
                                                  color: Colors.black
                                                      .withOpacity(0.15),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child:
                                                    "\$${state.data[index].price}"
                                                        .apply(
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: txtColor,
                                                            fontSize: 12)),
                                          ),
                                          width(40),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .incrementCartItemCount(
                                                            context, index)
                                                        .then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 15,
                                                  )),
                                            ),
                                          ),
                                          width(10),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: IconButton(
                                                  onPressed: () {},
                                                  icon: BlocBuilder<CartCubit,
                                                      CartState>(
                                                    builder: (context, state) {
                                                      return Text(
                                                        "${state.data[index].quantity}",
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold),
                                                      );
                                                    },
                                                  )),
                                            ),
                                          ),
                                          width(10),
                                          Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.black.withOpacity(0.15),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: SizedBox(
                                              height: 30,
                                              width: 30,
                                              child: IconButton(
                                                  onPressed: () {
                                                    context
                                                        .read<CartCubit>()
                                                        .decrementCartItemCount(
                                                            context, index)
                                                        .then((value) {
                                                      setState(() {});
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 15,
                                                  )),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                width(10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SizedBox(
                                    height: 40,
                                    width: 40,
                                    child: IconButton(
                                        onPressed: () {
                                          context
                                              .read<CartCubit>()
                                              .deleteSingleCart(
                                                  state.data[index].id ?? 0)
                                              .then((value) {
                                            setState(() {});
                                          });
                                        },
                                        icon: const Icon(Icons.delete)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                },
              ),
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: BlocBuilder<CartCubit, CartState>(
                          builder: (context, state) {
                            return Text(
                              "Total \$${state.total}",
                              style: const TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.w700),
                            );
                          },
                        )),
                  ),
                  width(50),
                  Expanded(
                      child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Place Order",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
                ],
              )),
          height(10)
        ],
      ),
    );
  }
}
