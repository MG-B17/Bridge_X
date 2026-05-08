import 'package:bridge_x/core/constant/bridge_x_strings.dart';

class AppValidator {
  const AppValidator._();


  static final _emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static final _phoneRegex = RegExp(r'^01[0125][0-9]{8}$');
  static final _urlRegex = RegExp(
    r'^https?:\/\/([\w-]+\.)+[\w-]+(\/[\w\-./?%&=]*)?$',
  );



  static String? required(String? value, [String? fieldName]) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null
          ? '$fieldName is required'
          : AppStrings.requiredField;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? emailOptional(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!_emailRegex.hasMatch(value.trim())) {
      return AppStrings.invalidEmail;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.length < 8) {
      return AppStrings.invalidPassword;
    }
    return null;
  }

  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return AppStrings.requiredField;
      }
      if (value != password) {
        return AppStrings.passwordMismatch;
      }
      return null;
    };
  }

  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (!_phoneRegex.hasMatch(value.trim())) {
      return AppStrings.invalidPhone;
    }
    return null;
  }

  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.requiredField;
    }
    if (value.trim().length < 2) {
      return AppStrings.invalidName;
    }
    return null;
  }

  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    if (!_urlRegex.hasMatch(value.trim())) {
      return AppStrings.invalidUrl;
    }
    return null;
  }
}
