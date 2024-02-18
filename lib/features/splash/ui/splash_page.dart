import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:task_app/features/cart/bloc/cart_cubit.dart';
import 'package:task_app/features/splash/bloc/splash_cubit.dart';
import '../../home/ui/home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
          statusBarIconBrightness:
              Platform.isAndroid ? Brightness.light : Brightness.dark,
          statusBarColor: Colors.transparent),
      child: Scaffold(
          body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state.isSplashTimeEnd) {
            context.read<CartCubit>().getCartList();
            Navigator.of(context).pushReplacement(PageTransition(
                child: const HomePage(), type: PageTransitionType.fade));
          }
        },
        builder: (context, state) {
          return Container(
            height: ScreenUtil().screenHeight,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 40.w),
            color: Colors.white,
            child: Image.asset(
              "assets/images/logo.png",
              width: ScreenUtil().screenWidth * 0.4,
            ),
          );
        },
      )),
    );
  }
}
