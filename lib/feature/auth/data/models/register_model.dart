import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';

class RegisterModel extends RegisterEntity{
  RegisterModel({
    required super.name,
    required super.email,
    required super.password,
    required super.passwordConfirmation,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'source' : 'mobile',
    };
  }
}