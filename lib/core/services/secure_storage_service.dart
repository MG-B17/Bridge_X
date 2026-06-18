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

  Future<bool?> readBool({required String key}) async {
    final val = await read(key: key);
    if (val == null) return null;
    if (val == 'true') return true;
    if (val == 'false') return false;
    return null;
  }

  Future<void> writeBool({required String key, required bool value}) async {
    await write(key: key, value: value ? 'true' : 'false');
  }

  Future<void> delete({required String key}) async {
    await secureStorage.delete(key: key);
  }

}
