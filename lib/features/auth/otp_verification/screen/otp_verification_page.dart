import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../widgets/otp_verification_form.dart';

class OtpVerificationPage extends StatelessWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: context.spacing.xl),
            child: const OtpVerificationForm(),
          ),
        ),
      ),
    );
  }
}
