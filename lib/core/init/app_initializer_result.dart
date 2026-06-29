import 'package:bridge_x/core/utils/models/user_data_model.dart';

class AppInitializerResult {
  final bool isLoggedIn;
  final bool hasSeenOnboarding;
  final UserDataModel? userData;

  const AppInitializerResult({
    required this.isLoggedIn,
    required this.hasSeenOnboarding,
    this.userData,
  });
}
