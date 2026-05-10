import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/navigation/bridge_x_route_constant.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/core/utils/enum/auth_enum.dart';
import 'package:bridge_x/core/widget/bridge_x_button.dart';
import 'package:bridge_x/core/widget/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_cubit.dart';
import 'package:bridge_x/feature/auth/presentation/controller/auth_state.dart';
import 'package:bridge_x/feature/auth/presentation/screens/forget_password/widgets/otp_widget.dart';
import 'package:bridge_x/core/widget/bridge_x_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OtpForm extends StatefulWidget {
  final String email;

  const OtpForm({super.key, required this.email});

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
            BlocConsumer<AuthCubit, AuthState>(
              listenWhen: (prev, curr) => curr.action == AuthAction.verifyPassword && prev.status != curr.status,
              buildWhen: (prev, curr) => curr.action == AuthAction.verifyPassword && prev.status != curr.status,
              listener: (context, state) {
                if (state.status == AuthStatus.success) {
                  BridgeXSnackBar.showSuccess(
                    context: context,
                    message: state.message ?? 'Verification successful',
                  );
                  context.push(AppRoute.changePassword, extra: {
                    'email': widget.email,
                    'code': state.resetToken ?? _code,
                  });
                }
              },
              builder: (context, state) => BridgeXButton(
                text: AppStrings.verify,
                isLoading: state.status == AuthStatus.loading,
                onTap: _code.length == 6
                    ? () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().verifyPassword(
                            email: widget.email,
                            code: _code,
                          );
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
}
