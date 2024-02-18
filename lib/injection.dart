import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:task_app/features/cart/bloc/cart_cubit.dart';
import 'package:task_app/features/detail/bloc/detail_cubit.dart';
import 'package:task_app/features/detail/repository/base_repository.dart';
import 'package:task_app/features/detail/repository/repository.dart';
import 'package:task_app/features/detail/usecase/usecase.dart';
import 'package:task_app/features/home/bloc/home_cubit.dart';
import 'package:task_app/features/home/repository/base_repository.dart';
import 'package:task_app/features/home/repository/repository.dart';
import 'package:task_app/features/home/usecase/usecase.dart';

import 'core/network/dio_factory.dart';
import 'core/network/network_info.dart';
import 'core/api_service/api_service.dart';
import 'features/splash/bloc/splash_cubit.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  instance.registerLazySingleton<DioFactory>(() => DioFactory());

  final dio = await instance<DioFactory>().getDio();
  instance.registerLazySingleton<ApiService>(() => ApiService(dio));

  //splash
  instance.registerFactory(() => SplashCubit());

//home
  instance.registerFactory(() => HomeCubit(instance()));
  instance.registerLazySingleton(() => HomeUseCase(instance()));
  instance.registerLazySingleton<BaseHomeRepository>(
      () => HomeRepository(instance(), instance()));

  //detail

  instance.registerFactory(() => DetailCubit(instance()));
  instance.registerLazySingleton(() => DetailUseCase(instance()));
  instance.registerLazySingleton<BaseDetailRepository>(
      () => DetailRepository(instance(), instance()));

  instance.registerFactory(() => CartCubit());
}
