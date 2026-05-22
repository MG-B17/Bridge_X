import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/core/navigation/screens_args/reset_password_args.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';

import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verfiy_code/widget/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpForm extends StatefulWidget {
  final String email;
  final AuthAction verifyAction;

  const OtpForm({super.key, required this.email, required this.verifyAction});

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
            VerticalSpacing(AppSpacing.xxl),
            VerticalSpacing(AppSpacing.md),
            widget.verifyAction == AuthAction.verifyPassword
                ? Center(
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
                  )
                : SizedBox.shrink(),
            const Spacer(),
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen: (prev, curr) =>
                  curr.action == widget.verifyAction && prev.status != curr.status,
              buildWhen: (prev, curr) =>
                  curr.action == widget.verifyAction && prev.status != curr.status,
              listener: (context, state) {
                if (state.status == AuthStatus.success) {
                  BridgeXSnackBar.showSuccess(
                    context: context,
                    message: state.message ?? AppFeedbackMessages.verificationSuccess,
                  );
                  widget.verifyAction == AuthAction.verifyPassword
                      ? context.pushNamed(
                          BridegeXRouteNames.resetPassword,
                          extra: ResetPasswordArgs(email: widget.email, token: state.resetToken!),
                        )
                      : context.pushNamed(BridegeXRouteNames.login);
                } else if (state.status == AuthStatus.error) {
                  for (final c in _controllers) {
                    c.clear();
                  }
                  _focusNodes[0].requestFocus();
                  setState(() => _code = '');
                  ErrorDialog.show(
                    context: context,
                    title: AppStrings.verificationFailed,
                    message: state.message ?? AppFeedbackMessages.invalidOtpMessage,
                  );
                }
              },
              builder: (context, state) => BridgeXButton(
                text: AppStrings.verify,
                isLoading: state.status == AuthStatus.loading,
                onTap: _code.length == 6
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          _buttonAction(context: context, verifyAction: widget.verifyAction);
                        }
                      }
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _buttonAction({required BuildContext context, required AuthAction verifyAction}) {
    switch (verifyAction) {
      case AuthAction.verifyPassword:
        context.read<AuthCubit>().verifyPassword(email: widget.email, code: _code);
        break;

      case AuthAction.verifyEmail:
        context.read<AuthCubit>().verifyEmail(email: widget.email, code: _code);
        break;

      default:
        break;
    }
  }
}
