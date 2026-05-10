import 'package:bridge_x/core/extensions/theme_extension.dart';
import 'package:bridge_x/core/utils/validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OtpWidget extends StatefulWidget {
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;

  const OtpWidget({
    super.key,
    this.onChanged,
    this.onCompleted,
    required this.controllers,
    required this.focusNodes
  });

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {

  void _onChanged(String value, int index) {
    String currentCode =widget.controllers.map((c) => c.text).join();
    widget.onChanged?.call(currentCode);
    
    if (value.isNotEmpty) {
      if (index < widget.controllers.length - 1) {
        widget.focusNodes[index + 1].requestFocus();
      } else {
        widget.focusNodes[index].unfocus();
        if (currentCode.length == widget.controllers.length) {
          widget.onCompleted?.call(currentCode);
        }
      }
    } else {
      if (index > 0) {
        widget.focusNodes[index - 1].requestFocus();
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final text = context.textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        widget.controllers.length,
        (index) => SizedBox(
          width: 45.w,
          height: 45.w,
          child: Center(
            child: Focus(
              onKeyEvent: (node, event) {
                if (event is KeyDownEvent && event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (widget.controllers[index].text.isEmpty && index > 0) {
                    widget.focusNodes[index - 1].requestFocus();
                    widget.controllers[index - 1].clear();
                    String currentCode = widget.controllers.map((c) => c.text).join();
                    widget.onChanged?.call(currentCode);
                    return KeyEventResult.handled;
                  }
                }
                return KeyEventResult.ignored;
              },
              child: TextFormField(
                controller: widget.controllers[index],
                focusNode: widget.focusNodes[index],
                onChanged: (value) => _onChanged(value, index),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                maxLength: 1,
                validator: AppValidator.otpDigit,
                style: text.headlineMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 24.sp,
                ),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  hintText: '·',
                  hintStyle: text.headlineMedium?.copyWith(color: colors.textHint),
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  filled: true,
                  fillColor: colors.surface,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.divider),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(color: colors.primary, width: 1.5),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
