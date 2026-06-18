import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';

abstract class AuthLocalDataSource {
  Future<void> clearSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SecureStorageService secureStorageService;
  final CacheService cacheService;

  AuthLocalDataSourceImpl({
    required this.secureStorageService,
    required this.cacheService,
  });

  @override
  Future<void> clearSession() async {
    await Future.wait([
      secureStorageService.delete(key: AppKeys.authToken),
      secureStorageService.delete(key: AppKeys.userId),
      secureStorageService.delete(key: AppKeys.userName),
      secureStorageService.delete(key: AppKeys.isVerified),
      secureStorageService.delete(key: AppKeys.trackSelectionCompleted),
      secureStorageService.delete(key: AppKeys.isProfileComplete),
      cacheService.clearData(),
    ]);
  }
}
