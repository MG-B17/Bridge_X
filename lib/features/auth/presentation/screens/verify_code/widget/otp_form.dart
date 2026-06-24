import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/features/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_cubit.dart';
import 'package:bridge_x/features/auth/presentation/controller/verification/verification_state.dart';
import 'package:bridge_x/features/auth/presentation/screens/verify_code/widget/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpForm extends StatefulWidget {
  final String email;
  final AuthAction verifyAction;
  final bool isLoading;
  final void Function(String code) onVerify;

  const OtpForm({
    super.key,
    required this.email,
    required this.verifyAction,
    required this.isLoading,
    required this.onVerify,
  });

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  String _code = '';
  final _formKey = GlobalKey<FormState>();
  late final List<FocusNode> _focusNodes;
  late final List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(6, (index) => FocusNode());
    _controllers = List.generate(6, (index) => TextEditingController());
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;

    return Expanded(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OtpWidget(
              controllers: _controllers,
              focusNodes: _focusNodes,
              onChanged: (val) {
                setState(() {
                  _code = val;
                });
              },
            ),
            VerticalSpacing(AppSpacing.xl),
            if (widget.verifyAction == AuthAction.verifyEmail)
              _buildResendSection()
            else
              Center(
                child: GestureDetector(
                  onTap: () {
                    context.pop();
                  },
                  child: Text(
                    AppStrings.wrongEmail,
                    style: text.bodyMedium?.copyWith(
                      color: colors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            const Spacer(),
            BridgeXButton(
              text: AppStrings.verify,
              isLoading: widget.isLoading,
              onTap: _code.length == 6
                  ? () {
                      if ((_formKey.currentState?.validate() ?? false)) {
                        widget.onVerify(_code);
                      }
                    }
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResendSection() {
    return BlocBuilder<VerificationCubit, VerificationState>(
      buildWhen: (p, c) => p.cooldownSeconds != c.cooldownSeconds || p.status != c.status,
      builder: (context, state) {
        final canResend = state.canResend && state.status != AuthStatus.loading;
        final colors = context.colors;
        final text = context.textTheme;
        return Center(
          child: GestureDetector(
            onTap: canResend
                ? () {
                    context.read<VerificationCubit>().resendVerify(email: widget.email);
                  }
                : null,
            child: Text(
              canResend ? AppStrings.resendCode : 'Resend code in ${state.cooldownSeconds}s',
              style: text.bodyMedium?.copyWith(
                color: canResend ? colors.accent : colors.textHint,
                fontWeight: canResend ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      },
    );
  }
}
