class ResetPasswordArgs {
  final String email;
  final String token;

  const ResetPasswordArgs({
    required this.email,
    required this.token,
  });
}