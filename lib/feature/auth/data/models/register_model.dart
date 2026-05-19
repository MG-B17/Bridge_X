import 'package:bridge_x/feature/auth/domain/entity/register_entity.dart';

class RegisterModel {
  final String name;
  final String email;
  final String password;
  final String passwordConfirmation;

  const RegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
  });

  factory RegisterModel.fromEntity(RegisterEntity entity) => RegisterModel(
        name: entity.name,
        email: entity.email,
        password: entity.password,
        passwordConfirmation: entity.passwordConfirmation,
      );

  Map<String, dynamic> toJson() {
    return {
      'full_name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation,
      'source': 'mobile',
    };
  }
}
