import 'package:bridge_x/core/constant/app_validation_messages.dart';

class AppValidator {
  const AppValidator._();

  static final _emailRegex = RegExp(r'^[\w\-\.]+@([\w\-]+\.)+[\w\-]{2,}$');
  static final _phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  static final _urlRegex   = RegExp(r'^https?:\/\/([\w-]+\.)+[\w-]+(\/[\w\-./?%&=]*)?$');

  static String? otpDigit(String? value) {
    if (value == null || value.trim().isEmpty) return '';
    if (!RegExp(r'^\d$').hasMatch(value.trim())) return '';
    return null;
  }

  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required'
          : AppValidationMessages.requiredField;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppValidationMessages.requiredField;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppValidationMessages.invalidEmail;
    }
    return null;
  }

  static String? emailOptional(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppValidationMessages.invalidEmail;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppValidationMessages.requiredField;
    }
    if (value.length < 8) {
      return AppValidationMessages.invalidPassword;
    }
    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return AppValidationMessages.passwordNeedsUppercase;
    }
    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return AppValidationMessages.passwordNeedsNumber;
    }
    if (!RegExp(r'[!@#$&*~%^]').hasMatch(value)) {
      return AppValidationMessages.passwordNeedsSpecial;
    }
    return null;
  }

  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return AppValidationMessages.requiredField;
      }
      if (value != password) {
        return AppValidationMessages.passwordMismatch;
      }
      return null;
    };
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppValidationMessages.requiredField;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return AppValidationMessages.invalidPhone;
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppValidationMessages.requiredField;
    }
    if (value.trim().length < 2) {
      return AppValidationMessages.invalidName;
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!_urlRegex.hasMatch(value.trim())) {
      return AppValidationMessages.invalidUrl;
    }
    return null;
  }
  static String? projectDescription(String? value, [String? fieldName]) {
    final req = required(value, fieldName);
    if (req != null) return req;
    if (value!.trim().length < 10) {
      return AppValidationMessages.invalidProjectDescription;
    }
    return null;
  }
}
