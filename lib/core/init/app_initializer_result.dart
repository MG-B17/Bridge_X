class AppInitializerResult {
  final bool isLoggedIn;
  final bool hasSeenOnboarding;
  final bool isVerified;
  final bool trackSelectionCompleted;
  final bool isProfileComplete;
  final String? username;

  AppInitializerResult({
    required this.isLoggedIn,
    required this.hasSeenOnboarding,
    required this.isVerified,
    required this.trackSelectionCompleted,
    required this.isProfileComplete,
    this.username,
  });
}
