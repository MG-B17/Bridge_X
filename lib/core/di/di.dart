import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../network/dio_factory.dart';
import '../network/network_info.dart';
import '../services/chache_service.dart'; 
import '../theme/theme_controller.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features
  // Cubits
  sl.registerLazySingleton(() => ThemeCubit(sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<CacheService>(() => CacheServiceImpl(sl()));
  sl.registerLazySingleton<Dio>(() => DioFactory().getDio());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnection());
}
