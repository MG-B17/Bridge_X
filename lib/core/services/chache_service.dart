import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheService {
  Future<bool> saveData({required String key, required dynamic value});
  dynamic getData({required String key});
  Future<bool> removeData({required String key});
  Future<bool> clearData();
}

class CacheServiceImpl implements CacheService {
  final SharedPreferences sharedPreferences;

  CacheServiceImpl(this.sharedPreferences);

  @override
  Future<bool> saveData({required String key, required dynamic value}) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    if (value is double) return await sharedPreferences.setDouble(key, value);
    return false;
  }

  @override
  dynamic getData({required String key}) {
    return sharedPreferences.get(key);
  }

  @override
  Future<bool> removeData({required String key}) async {
    return await sharedPreferences.remove(key);
  }

  @override
  Future<bool> clearData() async {
    return await sharedPreferences.clear();
  }
}
