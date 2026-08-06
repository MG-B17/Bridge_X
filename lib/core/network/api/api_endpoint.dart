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
  static const String myChats = "/api/teams/my-chats";
  static const String searchProgrammers = "/api/search/programmers";
  static String teamSettings({required int projectId}) =>
      "/api/teams/projects/$projectId/team-details";

  // projects
  static const String allProject = "/api/my-projects";
  static String projectDashboard({required int projectId}) =>
      "/api/zero-project/$projectId";

  static String projectDetails({required int projectId}) =>
      "/api/my-projects/$projectId/details";

  static String submitprojectAsComplete({required int projectId}) =>
      "/api/projects/$projectId/complete";

  static String changeLeader({required int projectId, required int userId}) =>
      "/api/projects/$projectId/change-leader/$userId";

  static String deleteTeam({required int projectId}) =>
      "/api/projects/$projectId/team";

  // tasks
  static String teamDetailsWithtasks({required int teamId}) =>
      "/api/team/$teamId/full-details";
  static String createTask({required int teamId}) =>
      "/api/tasks/team/$teamId";
  static String viewTask({required int projectId}) =>
      "/api/projects/$projectId/tasks";
  static const String tasksInProgress = "/api/tasks/in-progress";
  static const String tasksCompleted = "/api/tasks/completed";
  static String taskDetails({required int taskId}) => "/api/tasks/$taskId";

  //profile
  static const String profileData = "/api/my/dashboard";
  static const String updateProfile = "/api/profile/update";
  static const String displayProfile = "/api/profile";
  static const String softDeleteProfile = "/api/profile/soft-delete";
  static const String skillsExperience = "/api/profile/skills-experience";
  static const String level = "/api/my/level-progression";

  // reports
  static String reportInfo({required int userId}) =>
      "/api/user/$userId/report-info";
  static const String reports = "/api/reports";

  // team evaluation
  static String teamBasicDetails({required int projectId}) =>
      "/api/projects/$projectId/basic-details";
  static String evaluateAll({required int projectId}) =>
      "/api/projects/$projectId/evaluate-all";

  // ai matching
  static const String aiMatchTeams = "/api/ai/match-teams";

  // join requests
  static const String myJoinRequests = "/api/my/join-requests";
  static String joinRequestDetails({required int joinRequestId}) =>
      "/api/join-requests/$joinRequestId";
  static String sendJoinRequest({required int projectId}) =>
      "/api/projects/$projectId/join-request";
  static String acceptJoinRequest({required int joinRequestId}) =>
      "/api/join-requests/$joinRequestId/accept";
  static String declineJoinRequest({required int joinRequestId}) =>
      "/api/join-requests/$joinRequestId/decline";

  // notifications
  static const String notifications = "/api/notifications";
  static const String invitations = "/api/invitations";
  static String invitationDetails({required int invitationId}) =>
      "/api/invitations/$invitationId/details";
  static String acceptTeamInvitation({required int invitationId}) =>
      "/api/teams/invitations/$invitationId/accept";
  static String declineTeamInvitation({required int invitationId}) =>
      "/api/teams/invitations/$invitationId/decline";
  static String notificationRead({required String notificationId}) =>
      "/api/notifications/$notificationId/read";
  static const String notificationsReadAll = "/api/notifications/read-all";
  static const String notificationsUnreadCount =
      "/api/notifications/unread-count";
}
