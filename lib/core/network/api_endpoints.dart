class ApiEndpoints {
  const ApiEndpoints._();

  static const String baseUrl = 'https://api.example.com/v1';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String verifyOtp = '/auth/verify-otp';
  static const String forgotPassword = '/auth/forgot-password';
  static const String profileSetup = '/auth/profile-setup';

  // Home endpoints
  static const String dashboard = '/home/dashboard';

  // Teams endpoints
  static const String teams = '/teams';
  static const String aiMatching = '/teams/ai-matching';
  static const String joinTeam = '/teams/join';

  // Workspace endpoints
  static const String projects = '/workspace/projects';
  static const String tasks = '/workspace/tasks';

  // Chat endpoints
  static const String chats = '/chat/rooms';
  static const String messages = '/chat/messages';

  // Profile endpoints
  static const String profile = '/profile';
  static const String portfolio = '/profile/portfolio';

  // Notifications endpoints
  static const String notifications = '/notifications';

  // Company endpoints
  static const String talent = '/company/talent';
}
