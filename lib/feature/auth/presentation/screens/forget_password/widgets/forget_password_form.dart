import 'package:bridge_x/core/constant/app_feedback_messages.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/feedback/bridge_x_snackbar.dart';
import 'package:bridge_x/core/widget/inputs/bridge_x_text_form_field.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';

import 'package:bridge_x/core/widget/feedback/error_dialog.dart';
import 'package:bridge_x/core/navigation/screens_args/otp_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ForgetPasswordForm extends StatefulWidget {
  const ForgetPasswordForm({super.key});

  @override
  State<ForgetPasswordForm> createState() => _ForgetPasswordFormState();
}

class _ForgetPasswordFormState extends State<ForgetPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          BridgeXTextFormField(
            label: AppStrings.emailAddress,
            hint: AppStrings.emailHint,
            controller: _controller,
            validator: AppValidator.email,
            keyboardType: TextInputType.emailAddress,
            prefixIcon: Icons.email_outlined,
          ),
          VerticalSpacing(AppSpacing.xl),
          BlocConsumer<AuthCubit, AuthState>(
            listenWhen: (prev, curr) =>
                curr.action == AuthAction.forgetPassword && prev.status != curr.status,
            buildWhen: (prev, curr) =>
                curr.action == AuthAction.forgetPassword && prev.status != curr.status,
            listener: (context, state) {
              if (state.status == AuthStatus.success) {
                BridgeXSnackBar.showSuccess(
                  context: context,
                  message: state.message ?? AppFeedbackMessages.resetEmailSent,
                );
                context.pushNamed(
                  BridegeXRouteNames.verifyPasswordCode,
                  extra: OtpArgs(email: _controller.text,),
                );
              } else if (state.status == AuthStatus.error) {
                ErrorDialog.show(
                  context: context,
                  title: AppStrings.requestFailed,
                  message: state.message ?? AppFeedbackMessages.genericError,
                );
              }
            },
            builder: (context, state) => BridgeXButton(
              text: AppStrings.send,
              isLoading: state.status == AuthStatus.loading,
              onTap: state.status == AuthStatus.loading
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthCubit>().forgetPassword(email: _controller.text.trim());
                      }
                    },
            ),
          ),
        ],
      ),
    );
  }
}
