import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/core/constants/color_const.dart';
import 'package:task_app/core/extension/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/core/model/db_model.dart';
import 'package:task_app/core/utils/height_util.dart';
import 'package:task_app/core/utils/sqflite_util.dart';
import 'package:task_app/core/utils/width_util.dart';
import 'package:task_app/features/detail/bloc/detail_cubit.dart';
import 'package:task_app/widgets/failure_widget.dart';

import '../../cart/bloc/cart_cubit.dart';
import '../../cart/ui/cart_page.dart';

class DetailPage extends StatelessWidget {
  final int id;

  const DetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: AppBar(
        backgroundColor: g1,
        title: "Product Details".apply(
            color: txtColor, fontWeight: FontWeight.w500, fontSize: 14.sp),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: SizedBox(
              height: 40,
              width: 40,
              child: Stack(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                            child: const CartPage(),
                            type: PageTransitionType.rightToLeft));
                      },
                      icon: SvgPicture.asset(
                        "assets/icons/cart-shopping-fast.svg",
                        height: 24,
                        width: 24,
                        colorFilter:
                            const ColorFilter.mode(txtColor, BlendMode.srcIn),
                      )),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 20,
                          width: 20,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.red),
                          child: BlocBuilder<CartCubit, CartState>(
                            builder: (context, state) {
                              if (state.loading) {
                                return const Text("0");
                              }
                              return Text(
                                "${state.data.length}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.white),
                              );
                            },
                          )))
                ],
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DetailCubit, DetailState>(
          builder: (context, state) {
            if (state.loading) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[100]!,
                    highlightColor: Colors.grey[300]!,
                    child: Container(
                      width: double.infinity,
                      height: 200,
                      color: Colors.grey[100],
                    ),
                  ),
                ),
              );
            }
            if (state.errorMessage.isNotEmpty) {
              return FailureWidget(
                error: state.errorMessage,
                isExitButtonShow: false,
                onRetryTap: () {
                  context.read<DetailCubit>().getProductDetail(id);
                },
              );
            }
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(9),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: CachedNetworkImage(
                              width: double.infinity,
                              height: 200,
                              imageUrl: state.data.image ??
                                  "https://dummyimage.com/800x430/2d5b2d/ut-posuere.png&text=jsonplaceholder.org",
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.red, BlendMode.colorBurn)),
                                ),
                              ),
                              placeholder: (context, url) => Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[100]!,
                                    highlightColor: Colors.grey[300]!,
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      color: Colors.grey[100],
                                    ),
                                  ),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Column(
                            children: [
                              state.data.title.toString().apply(
                                  fontWeight: FontWeight.w500,
                                  color: txtColor,
                                  fontSize: 15),
                              height(10),
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 30, vertical: 10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          "Price".apply(
                                              fontWeight: FontWeight.w500,
                                              color: txtColor,
                                              fontSize: 12),
                                          "\$${state.data.id}".apply(
                                              fontWeight: FontWeight.w500,
                                              color: txtColor,
                                              fontSize: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  width(30),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          "Category".apply(
                                              fontWeight: FontWeight.w500,
                                              color: txtColor,
                                              fontSize: 12),
                                          "${state.data.category}".apply(
                                              fontWeight: FontWeight.w500,
                                              color: txtColor,
                                              fontSize: 15),
                                        ],
                                      ),
                                    ),
                                  ),
                                  width(30),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white),
                                      child: Column(
                                        children: [
                                          "Status".apply(
                                              fontWeight: FontWeight.w500,
                                              color: txtColor,
                                              fontSize: 12),
                                          "${state.data.status}".apply(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.blue,
                                              fontSize: 15),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              height(20),
                              Row(
                                children: [
                                  "Description".apply(
                                      fontWeight: FontWeight.w500,
                                      color: txtColor,
                                      fontSize: 15),
                                  width(10),
                                  const Expanded(
                                      child: Divider(
                                    height: 1,
                                    color: Colors.grey,
                                    thickness: 1,
                                  ))
                                ],
                              ),
                              height(10),
                              state.data.content.toString().apply(
                                  fontWeight: FontWeight.w400,
                                  color: txtColor,
                                  fontSize: 13),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    color: Colors.white,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
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
                                        .incrementalEvent();
                                  },
                                  icon: const Icon(Icons.add)),
                            ),
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: BlocBuilder<CartCubit, CartState>(
                                    builder: (context, state) {
                                      return Text(
                                        state.increment.toString(),
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      );
                                    },
                                  )),
                            ),
                          ),
                        ),
                        width(10),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
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
                                        .decrementalEvent();
                                  },
                                  icon: const Icon(Icons.remove)),
                            ),
                          ),
                        ),
                        width(50),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: SizedBox(
                              height: 40,
                              width: 40,
                              child: IconButton(
                                  onPressed: () {},
                                  icon: SvgPicture.asset(
                                      "assets/icons/heart.svg",
                                      width: 30,
                                      colorFilter: const ColorFilter.mode(
                                          Colors.red, BlendMode.srcIn))),
                            ),
                          ),
                        ),
                        width(10),
                        Expanded(
                            child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: IconButton(
                              onPressed: () {
                                var stateC = context.read<CartCubit>().state;
                                CartProvider.open().then((value) {
                                  CartProvider.insert(DbProductModel(
                                          id: state.data.id ?? 0,
                                          title: state.data.title ?? "",
                                          content: state.data.content ?? "",
                                          thumbnail: state.data.thumbnail ?? "",
                                          price: state.data.userId!.toDouble(),
                                          quantity: stateC.increment,
                                          total: state.data.userId!.toDouble() *
                                              stateC.increment))
                                      .then((value) {
                                    context.read<CartCubit>().getCartList();
                                    value.showToast(
                                        context, Colors.white, txtColor);
                                  });
                                });
                              },
                              icon: Image.asset(
                                "assets/images/add-to-cart.png",
                                height: 20,
                              )),
                        )),
                      ],
                    )),
                height(10)
              ],
            );
          },
        ),
      ),
    );
  }
}
