class AppValidationMessages {
  const AppValidationMessages._();

  static const String requiredField = 'This field is required';

  static const String invalidPhone = 'Please enter a valid phone number';
  static const String invalidEmail = 'Please enter a valid email address';
  static const String invalidName = 'Name must be at least 2 characters';
  static const String invalidUrl = 'Please enter a valid URL';
  static const String invalidOtp = 'Invalid OTP code';
  static const String invalidPassword = 'Password must be at least 8 characters';
  static const String passwordNeedsUppercase = 'Must contain at least one uppercase letter';
  static const String passwordNeedsNumber = 'Must contain at least one number';
  static const String passwordNeedsSpecial = 'Must contain a special character (!@#\$&*~%^)';
  static const String passwordMismatch = 'Passwords do not match';
  static const String passwordMinLength = 'Password must be at least 8 characters long.';
  static const String invalidProjectDescription = 'Description must be at least 10 characters';
}
