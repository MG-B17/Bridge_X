import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/utils/extensions.dart';

class OtpInputRow extends StatefulWidget {
  final ValueChanged<String> onCompleted;
  final bool isError;

  const OtpInputRow({
    super.key,
    required this.onCompleted,
    this.isError = false,
  });

  @override
  State<OtpInputRow> createState() => _OtpInputRowState();
}

class _OtpInputRowState extends State<OtpInputRow> {
  final int _length = 4;
  late List<FocusNode> _focusNodes;
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _focusNodes = List.generate(_length, (index) => FocusNode());
    _controllers = List.generate(_length, (index) => TextEditingController());
    for (int i = 0; i < _length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.isNotEmpty && i < _length - 1){
          _focusNodes[i + 1].requestFocus();}
        _checkCompletion();
      });
    }
  }

  void _checkCompletion() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length == _length) widget.onCompleted(code);
  }

  @override
  void dispose() {
    for (var node in _focusNodes){ node.dispose();}
    for (var controller in _controllers) {controller.dispose();}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(_length, (index) {
        final border = OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: widget.isError
                ? Colors.red
                : context.colors.textHint.withValues(alpha: 0.3),
          ),
        );
        return SizedBox(
          width: 56.w,
          height: 64.w,
          child: TextFormField(
            controller: _controllers[index],
            focusNode: _focusNodes[index],
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: context.displayLarge.copyWith(
              color: context.colors.primary,
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
            ),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              counterText: '',
              hintText: '·',
              hintStyle: context.displayLarge.copyWith(
                color: context.colors.textHint.withValues(alpha: 0.5),
                fontSize: 24.sp,
              ),
              filled: true,
              fillColor: context.colors.surface,
              contentPadding: EdgeInsets.zero,
              border: border,
              enabledBorder: border,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: widget.isError ? Colors.red : context.colors.primary,
                ),
              ),
            ),
            onChanged: (val) {
              if (val.isEmpty && index > 0){
                _focusNodes[index - 1].requestFocus();}
            },
          ),
        );
      }),
    );
  }
}
