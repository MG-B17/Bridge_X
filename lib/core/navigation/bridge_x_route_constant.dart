class AppRoute {
  AppRoute._(); // Prevent instantiation

  //Auth 
  static const String splash = '/';
  static const String login = '/login';
  static const String signUp = '/signup';
  static const String forgotPassword = '/forgot-password';
  static const String verifyCode = '/verify-code';
  static const String completeProfile = '/complete-profile';
  static const String matching = '/matching';

  //Main Shell 
  static const String layout = '/layout';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String projects = '/projects';
  static const String profile = '/profile';

  //Sub-routes
  static const String notifications = '/notifications';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String changePassword = '/change-password';
  static const String privacySecurity = '/privacy-security';
  static const String aboutUs = '/about-us';
}
