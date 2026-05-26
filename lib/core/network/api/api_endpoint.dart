class ApiEndpoint {
  // Authentication Endpoints
  static const String login = "/api/login";
  static const String register = "/api/register";
  static const String completeProfile = "/api/register/complete-profile";
  static const String verifyEmail = "/api/register/verify";
  static const String forgetPassword = "/api/forgot-password";
  static const String resetPassword = "/api/reset-password";
  static const String verifyPassword = "/api/reset-password/verify";
  static const String resendVerificationCode = "/api/register/resend-code";
  static const String logout = "/api/logout";
  static const String changePassword = "/api/change-password";
  static const String googleRedirect = "/api/auth/google/redirect";
  static const String googleCallback = "/api/auth/google/callback";
  static const String facebookRedirect = "/api/auth/facebook/redirect";
  static const String gitHubRedirect = "/api/auth/github/redirect";

  // dashboard
  static const String dashboard = "/api/my/statistics";

  // teams
  static const String createTeam = "/api/teams";
  static String teamSettings({required int projectId}) =>
      "/api/teams/$projectId/details";

  // projects 
  static const String allProject = "/api/my-projects";
  static String projectDashboard({required int projectId}) =>
      "/api/zero-project/$projectId";

  static String projectDetails({required int projectId}) =>
      "/api/my-projects/$projectId/details";

  static String submitprojectAsComplete({required int projectId}) =>
      "/api/projects/$projectId/complete";    

  // tasks 
  static String teamDetailsWithtasks({required int teamId}) =>
      "/api/team/$teamId/full-details";
  static String createTask({required int projectId}) =>
      "/api/tasks/team/$projectId";
  static String viewTask({required int projectId}) =>
      "/api/team/$projectId/full-details";

  //profile 
  static const String profileData = "/api/my/dashboard";
  static const String updateProfile = "/api/profile/update";
  static const String displayProfile = "/api/profile";
  static const String level = "/api/my/level-progression";

  // reports
  static String reportInfo({required int userId}) => "/api/user/$userId/report-info";
  static const String reports = "/api/reports";

}
