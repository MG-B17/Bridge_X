import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_initializer_result.dart';
import 'package:bridge_x/core/services/cache_service.dart';
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

    // Migrate onboarding flag from SharedPreferences to SecureStorage
    bool hasSeenOnboarding;
    final secureOnboarding =
        await sl<SecureStorageService>().readBool(key: AppKeys.onboardingSeenKey);
    if (secureOnboarding != null) {
      hasSeenOnboarding = secureOnboarding;
    } else {
      hasSeenOnboarding =
          sl<CacheService>().getData(key: AppKeys.onboardingSeenKey) as bool? ??
          false;
      if (hasSeenOnboarding) {
        await sl<SecureStorageService>().writeBool(
          key: AppKeys.onboardingSeenKey,
          value: true,
        );
      }
    }

    final isVerified =
        await sl<SecureStorageService>().readBool(key: AppKeys.isVerified) ??
        false;

    final trackSelectionCompleted =
        await sl<SecureStorageService>().readBool(
          key: AppKeys.trackSelectionCompleted,
        ) ??
        false;

    final isProfileComplete =
        await sl<SecureStorageService>().readBool(
          key: AppKeys.isProfileComplete,
        ) ??
        false;

    final username =
        await sl<SecureStorageService>().read(key: AppKeys.userName);

    return AppInitializerResult(
      isLoggedIn: token?.isNotEmpty ?? false,
      hasSeenOnboarding: hasSeenOnboarding,
      isVerified: isVerified,
      trackSelectionCompleted: trackSelectionCompleted,
      isProfileComplete: isProfileComplete,
      username: username,
    );
  }
}
