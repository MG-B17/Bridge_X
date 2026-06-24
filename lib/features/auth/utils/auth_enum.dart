enum AuthAction {
  login,
  register,
  verifyEmail,
  resendVerify,
  forgetPassword,
  verifyPassword,
  resetPassword,
  changePassword,
  logout,
  softDeleteProfile,
  completeProfile,
}


enum AuthStatus {
  initial,
  loading,
  success,
  error,
}
