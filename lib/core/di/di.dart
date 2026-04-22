import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:bridgex/core/helper/cache/cache_helper.dart';
import 'package:bridgex/core/network/network_info.dart';
import 'package:bridgex/core/network/api_client.dart';

final sl = GetIt.instance;

Future<void> initDi() async {
  // ─── Local Storage
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);
  sl.registerLazySingleton<CacheHelper>(() => CacheHelper(sharedPreferences));

  // ─── Network
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnection()));
  sl.registerLazySingleton<ApiClient>(() => ApiClient(
    dio: Dio(),
    cacheHelper: sl(),
  ));

  // ─── Data Sources

  // ─── Repositories

  // ─── Use Cases

  // ─── Bloc / Cubit
}
