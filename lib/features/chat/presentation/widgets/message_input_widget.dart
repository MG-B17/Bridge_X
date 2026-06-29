import 'package:flutter/material.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';

class MessageInputWidget extends StatefulWidget {
  final ValueChanged<String> onSend;

  const MessageInputWidget({super.key, required this.onSend});
  
  static const int maxMessageLength = 2000;

  @override
  State<MessageInputWidget> createState() => _MessageInputWidgetState();
}

class _MessageInputWidgetState extends State<MessageInputWidget> {
  final _controller = TextEditingController();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) setState(() => _hasText = hasText);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSend() {
    final text = _controller.text.trim();
    if (text.isEmpty || text.length > MessageInputWidget.maxMessageLength) return;
    widget.onSend(text);
    _controller.clear();
    setState(() => _hasText = false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.colors.surface,
      padding: EdgeInsets.only(
        left: AppSpacing.spacing16,
        right: AppSpacing.spacing16,
        top: AppSpacing.height8,
        bottom: MediaQuery.paddingOf(context).bottom + AppSpacing.height8,
      ),
      child: SafeArea(
        top: false,
        child: Container(
          decoration: BoxDecoration(
            color: context.colors.primaryLight,
            borderRadius: BorderRadius.circular(AppSpacing.radius30),
          ),
          padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing6, vertical: AppSpacing.height4),
          child: Row(
            children: [
              IconButton(
                onPressed: null,
                icon: Icon(
                  Icons.attach_file_rounded,
                  color: context.colors.textHint,
                  size: AppSpacing.fontSize24,
                ),
                tooltip: 'Attach file',
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  maxLength: MessageInputWidget.maxMessageLength,
                  maxLines: 4,
                  minLines: 1,
                  textCapitalization: TextCapitalization.sentences,
                  style: TextStyle(
                    fontSize: AppSpacing.fontSize15,
                    color: context.colors.textPrimary,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: context.colors.textHint,
                      fontSize: AppSpacing.fontSize15,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing8, vertical: AppSpacing.height10),
                    counterText: '',
                  ),
                  textInputAction: TextInputAction.newline,
                ),
              ),
              SizedBox(width: AppSpacing.spacing4),
              _SendButton(hasText: _hasText, onSend: _handleSend),
            ],
          ),
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final bool hasText;
  final VoidCallback onSend;

  const _SendButton({required this.hasText, required this.onSend});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: hasText ? onSend : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: AppSpacing.iconBoxSize,
        height: AppSpacing.iconBoxSize,
        decoration: BoxDecoration(
          color: hasText ? context.colors.primary : context.colors.primaryLight,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Icon(
            Icons.send_rounded,
            color: context.colors.surface,
            size: AppSpacing.fontSize20,
          ),
        ),
      ),
    );
  }
}
