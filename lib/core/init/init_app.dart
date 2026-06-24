import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/init/app_initializer_result.dart';
import 'package:bridge_x/core/services/cache_service.dart';
import 'package:bridge_x/core/services/secure_storage_service.dart';
import 'package:bridge_x/core/utils/models/user_data_model.dart';

class AppInitializer {
  Future<AppInitializerResult> init() async {
    final results = await Future.wait([
      sl<SecureStorageService>().read(key: AppKeys.authToken),
      sl<SecureStorageService>().readBool(key: AppKeys.onboardingSeenKey),
      sl<SecureStorageService>().read(key: AppKeys.userDataKey),
    ]);

    final token = results[0] as String?;
    final secureOnboarding = results[1] as bool?;
    final userData = results[2] as String?;

    // Safeguard: Clear legacy invalid token stored due to the previous login bug
    if (token != null &&
        (token == 'Login successful.' || !token.contains('|'))) {
      await sl<SecureStorageService>().delete(key: AppKeys.authToken);
      return AppInitializerResult(
        isLoggedIn: false,
        hasSeenOnboarding: _migrateOnboardingFlag(secureOnboarding),
        userData: null,
      );
    }

    final hasSeenOnboarding = _migrateOnboardingFlag(secureOnboarding);

    UserDataModel? decodedUserData;
    if (userData != null && userData.isNotEmpty) {
      decodedUserData = UserDataModel.userDecodedata(userEncodedData: userData);
    }

    final isLoggedIn = token?.isNotEmpty ?? false;

    if (isLoggedIn &&
        decodedUserData != null &&
        (!decodedUserData.isProfileComplete ||
            decodedUserData.userName.isEmpty)) {
      await sl<SecureStorageService>().delete(key: AppKeys.authToken);
      await sl<SecureStorageService>().delete(key: AppKeys.userDataKey);
      await sl<CacheService>().clearData();
      return AppInitializerResult(
        isLoggedIn: false,
        hasSeenOnboarding: hasSeenOnboarding,
        userData: null,
      );
    }

    return AppInitializerResult(
      isLoggedIn: isLoggedIn,
      hasSeenOnboarding: hasSeenOnboarding,
      userData: decodedUserData,
    );
  }

  bool _migrateOnboardingFlag(bool? secureOnboarding) {
    if (secureOnboarding != null) return secureOnboarding;

    final cached =
        sl<CacheService>().getData(key: AppKeys.onboardingSeenKey) as bool?;
    if (cached == true) {
      sl<SecureStorageService>().writeBool(
        key: AppKeys.onboardingSeenKey,
        value: true,
      );
    }
    return cached ?? false;
  }
}
