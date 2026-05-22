import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_initializer_result.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';

class AppInitializer {
  Future<AppInitializerResult> init() async {
    var token =
        await sl<SecureStorageService>().read(key: AppKeys.authToken);

    // Safeguard: Clear legacy invalid token stored due to the previous login bug
    if (token != null && (token == 'Login successful.' || !token.contains('|'))) {
      await sl<SecureStorageService>().delete(key: AppKeys.authToken);
      token = null;
    }

    final hasSeenOnboarding =
        sl<CacheService>().getData(key: AppKeys.onboardingSeenKey) as bool? ??
        false;

    return AppInitializerResult(
      isLoggedIn: token?.isNotEmpty ?? false,
      hasSeenOnboarding: hasSeenOnboarding,
    );
  }
}
