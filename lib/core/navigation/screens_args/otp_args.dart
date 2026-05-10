import 'package:bridge_x/core/utils/enum/auth_enum.dart';

class OtpArgs {
  final String email;
  final AuthAction verifyAction;

  const OtpArgs({
    required this.email,
    required this.verifyAction,
  });
}