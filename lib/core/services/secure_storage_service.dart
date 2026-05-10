import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {

  final FlutterSecureStorage secureStorage;

  SecureStorageService({required this.secureStorage});

  Future<void> write({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> read({required String key}) async {
    return await secureStorage.read(key: key);
  }   

  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

}