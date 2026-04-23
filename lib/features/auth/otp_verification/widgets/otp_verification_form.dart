import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constant/app_strings.dart';
import '../../../../core/utils/extensions.dart';
import '../../widgets/auth_header.dart';
import '../../../../core/widgets/bridge_app_button.dart';
import '../../widgets/otp_input_row.dart';
import '../../../../core/widgets/v_space.dart';
import 'otp_verification_actions.dart';

class OtpVerificationForm extends StatefulWidget {
  const OtpVerificationForm({super.key});

  @override
  State<OtpVerificationForm> createState() => _OtpVerificationFormState();
}

class _OtpVerificationFormState extends State<OtpVerificationForm> {
  String _otpCode = '';
  bool _isError = false;

  void _verifyCode() {
    if (_otpCode.length == 4) {
      if (_otpCode == '1234') { 
        setState(() => _isError = false);
      } else {
        setState(() => _isError = true);
      }
    } else {
      setState(() => _isError = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(24.r), 
        boxShadow: [context.spacing.cardShadow],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl, vertical: 48.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const AuthHeader(
              title: AppStrings.verifyCode,
              subtitle: AppStrings.verifyDescription,
            ),
            OtpInputRow(
              isError: _isError,
              onCompleted: (code) {
                setState(() {
                  _otpCode = code;
                  _isError = false; 
                });
              },
            ),
            VSpace(context.spacing.md),
            if (_isError)
              Row(
                children: [
                  Icon(Icons.error, color: Colors.red, size: 16.w),
                  SizedBox(width: 8.w),
                  Text(
                    AppStrings.invalidCode,
                    style: context.labelSmall.copyWith(color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            else
              SizedBox(height: 16.w), 
            VSpace(32.h),
            const OtpVerificationActions(),
            VSpace(48.h),
            AppButton(label: AppStrings.verify, onPressed: _verifyCode),
          ],
        ),
      ),
    );
  }
}
