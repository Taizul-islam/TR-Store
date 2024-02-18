
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:task_app/features/cart/bloc/cart_cubit.dart';
import 'package:task_app/features/detail/bloc/detail_cubit.dart';
import 'package:task_app/features/home/bloc/home_cubit.dart';
import 'package:task_app/injection.dart' as injection;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/splash/bloc/splash_cubit.dart';
import 'features/splash/ui/splash_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await injection.initAppModule();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => injection.instance<SplashCubit>()),

        BlocProvider(
            create: (context) => injection.instance<HomeCubit>()),

        BlocProvider(
            create: (context) => injection.instance<DetailCubit>()),

        BlocProvider(
            create: (context) => injection.instance<CartCubit>()),

      ],
      child: ScreenUtilInit(
        minTextAdapt: true,
        designSize: const Size(360, 760),
        splitScreenMode: true,
        child: MaterialApp(
          title: 'TR Store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const SplashPage(),
        ),
      ),
    );
  }
}
