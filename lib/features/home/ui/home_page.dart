import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_app/core/constants/color_const.dart';
import 'package:task_app/core/extension/extensions.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_app/core/utils/height_util.dart';
import 'package:task_app/core/utils/width_util.dart';
import 'package:task_app/features/cart/bloc/cart_cubit.dart';
import 'package:task_app/features/cart/ui/cart_page.dart';
import 'package:task_app/features/detail/bloc/detail_cubit.dart';
import 'package:task_app/features/detail/ui/detail_page.dart';
import 'package:task_app/features/home/bloc/home_cubit.dart';
import 'package:shimmer/shimmer.dart';
import 'package:task_app/widgets/failure_widget.dart';

import '../../../core/model/db_model.dart';
import '../../../core/utils/sqflite_util.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFf7f7f7),
      appBar: AppBar(
        backgroundColor: g1,
        title: "Products".apply(
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
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state.loading) {
            return StaggeredGridView.countBuilder(
                crossAxisCount: 12,
                padding: const EdgeInsets.only(
                    left: 20, right: 20, bottom: 30, top: 20),
                itemCount: 22,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFF77CEDA).withOpacity(0.2),
                                offset: const Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      child: Column(
                        children: [
                          Padding(
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
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[100]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 18,
                                    color: Colors.grey[100],
                                  ),
                                ),
                                height(5),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[100]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 15,
                                    color: Colors.grey[100],
                                  ),
                                ),
                                height(5),
                                Shimmer.fromColors(
                                  baseColor: Colors.grey[100]!,
                                  highlightColor: Colors.grey[300]!,
                                  child: Container(
                                    width: double.infinity,
                                    height: 34,
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ));
                },
                staggeredTileBuilder: (int index) {
                  return const StaggeredTile.fit(6);
                });
          }
          if (state.errorMessage.isNotEmpty) {
            return FailureWidget(
              error: state.errorMessage,
              isExitButtonShow: false,
              onRetryTap: () {
                context.read<HomeCubit>().getProductList();
              },
            );
          }
          return StaggeredGridView.countBuilder(
              crossAxisCount: 12,
              padding: const EdgeInsets.only(
                  left: 20, right: 20, bottom: 30, top: 20),
              itemCount: state.data.length,
              physics: const BouncingScrollPhysics(),
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final item = state.data[index];
                return GestureDetector(
                  onTap: () {
                    context.read<DetailCubit>().getProductDetail(item.id ?? 0);
                    Navigator.of(context).push(PageTransition(
                        child: DetailPage(
                          id: item.id ?? 0,
                        ),
                        type: PageTransitionType.rightToLeft));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xFF77CEDA).withOpacity(0.2),
                                offset: const Offset(0, 0),
                                blurRadius: 20)
                          ]),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                width: double.infinity,
                                height: 150,
                                imageUrl: item.image ??
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
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                item.title.toString().apply(
                                    fontWeight: FontWeight.w500,
                                    color: txtColor,
                                    fontSize: 13),
                                height(5),
                                item.content.toString().apply(
                                    fontWeight: FontWeight.w400,
                                    color: txtColor,
                                    fontSize: 11,
                                    maxLine: 2,
                                    textOverflow: TextOverflow.ellipsis),
                                height(5),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          height: 33,
                                          width: 33,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: "\$${item.userId}".apply(
                                                  fontWeight: FontWeight.w500,
                                                  color: txtColor,
                                                  fontSize: 12)),
                                        ),
                                      ),
                                    ),
                                    width(10),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(0.15),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: SizedBox(
                                          height: 33,
                                          width: 33,
                                          child: IconButton(
                                              onPressed: () {},
                                              icon: SvgPicture.asset(
                                                  "assets/icons/heart.svg",
                                                  width: 30,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                          Colors.red,
                                                          BlendMode.srcIn))),
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
                                            CartProvider.open().then((value) {
                                              CartProvider.insert(
                                                      DbProductModel(
                                                          id: item.id ?? 0,
                                                          title:
                                                              item.title ?? "",
                                                          content:
                                                              item.content ??
                                                                  "",
                                                          thumbnail:
                                                              item.thumbnail ??
                                                                  "",
                                                          price: item.userId!
                                                              .toDouble(),
                                                          quantity: 1,
                                                          total: item.userId!
                                                              .toDouble()))
                                                  .then((value) {
                                                context
                                                    .read<CartCubit>()
                                                    .getCartList();
                                                value.showToast(context,
                                                    Colors.white, txtColor);
                                              });
                                            });
                                          },
                                          icon: Image.asset(
                                            "assets/images/add-to-cart.png",
                                            height: 20,
                                          )),
                                    )),
                                  ],
                                )
                              ],
                            ),
                          )
                        ],
                      )),
                );
              },
              staggeredTileBuilder: (int index) {
                return const StaggeredTile.fit(6);
              });
        },
      ),
    );
  }
}
