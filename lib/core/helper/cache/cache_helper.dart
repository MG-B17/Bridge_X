import 'package:shared_preferences/shared_preferences.dart';

abstract class CacheHelper {
  Future<bool> saveToken(String token);
  String? getToken();
  Future<bool> deleteToken();

  Future<bool> saveUserRole(String role);
  String? getUserRole();

  Future<bool> setFirstLaunch(bool isFirst);
  bool isFirstLaunch();
}

class CacheHelperImpl implements CacheHelper {
  final SharedPreferences sharedPreferences;

  CacheHelperImpl({required this.sharedPreferences});

  static const String _tokenKey = 'auth_token';
  static const String _roleKey = 'user_role';
  static const String _firstLaunchKey = 'first_launch';

  @override
  Future<bool> deleteToken() async {
    return await sharedPreferences.remove(_tokenKey);
  }

  @override
  String? getToken() {
    return sharedPreferences.getString(_tokenKey);
  }

  @override
  String? getUserRole() {
    return sharedPreferences.getString(_roleKey);
  }

  @override
  bool isFirstLaunch() {
    return sharedPreferences.getBool(_firstLaunchKey) ?? true;
  }

  @override
  Future<bool> saveToken(String token) async {
    return await sharedPreferences.setString(_tokenKey, token);
  }

  @override
  Future<bool> saveUserRole(String role) async {
    return await sharedPreferences.setString(_roleKey, role);
  }

  @override
  Future<bool> setFirstLaunch(bool isFirst) async {
    return await sharedPreferences.setBool(_firstLaunchKey, isFirst);
  }
}
