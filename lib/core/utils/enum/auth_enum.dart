enum AuthAction {
  login,
  register,
  verifyEmail,
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
