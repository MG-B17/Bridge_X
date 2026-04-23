import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../widgets/forget_password_form.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.xl),
            child: const ForgetPasswordForm(),
          ),
        ),
      ),
    );
  }
}
