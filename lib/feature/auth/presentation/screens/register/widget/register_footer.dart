import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/feature/auth/presentation/auth_widget/auth_footer.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegisterFooter extends StatelessWidget {
  const RegisterFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFooter(
      prefixText: AppStrings.alreadyHaveAccountPrefix,
      actionText: AppStrings.login,
      onActionTap: () => context.goNamed(BridegeXRouteNames.login),
    );
  }
}
