import 'package:bridge_x/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class BridgeXTextButton extends StatelessWidget {
  const BridgeXTextButton({super.key, required this.text, required this.onTap});
  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(text,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:context.appColors.ongoingText),),
    );
  }
}