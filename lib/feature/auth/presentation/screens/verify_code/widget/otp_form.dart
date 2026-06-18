import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';
import 'package:bridge_x/feature/auth/utils/auth_enum.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_button.dart';
import 'package:bridge_x/core/widget/layout/vertical_spacing.dart';
import 'package:bridge_x/feature/auth/presentation/screens/verify_code/widget/otp_widget.dart';
import 'package:flutter/material.dart';
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
                : const SizedBox.shrink(),
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
}
