class VerifyPasswordResultEntity {
  final String resetToken;
  final String message;
  final String expiresAt;

  const VerifyPasswordResultEntity({
    required this.resetToken,
    required this.message,
    required this.expiresAt,
  });
}
