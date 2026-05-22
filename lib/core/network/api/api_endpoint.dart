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


  //dashboard
  static const String dashboard = "/api/my/statistics"; 

  
}
