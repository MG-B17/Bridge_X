import 'package:flutter/material.dart';
import 'package:bridge_x/core/extensions/context_extension.dart';
import 'package:bridge_x/core/utils/app_spacing.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const SearchBarWidget({
    super.key,
    required this.onSearch,
  });

  static const double searchBarHeight = 52;

  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing16, vertical: AppSpacing.height8),
      child: Container(
        height: SearchBarWidget.searchBarHeight,
        decoration: BoxDecoration(
          color: context.colors.scaffoldBg,
          borderRadius: BorderRadius.circular(AppSpacing.radius28),
        ),
        child: Center(
          child: TextField(
            controller: _controller,
            style: TextStyle(
              fontSize: AppSpacing.fontSize16,
              color: context.colors.textPrimary,
            ),
            decoration: InputDecoration(
              hintText: 'Search teams or messages...',
              hintStyle: TextStyle(
                color: context.colors.textHint,
                fontSize: AppSpacing.fontSize15,
              ),
              prefixIcon: Padding(
                padding: EdgeInsets.symmetric(horizontal: AppSpacing.spacing12),
                child: Icon(
                  Icons.search,
                  color: context.colors.textHint,
                  size: AppSpacing.fontSize22,
                ),
              ),
              prefixIconConstraints: BoxConstraints(
                minWidth: AppSpacing.spacing40,
                minHeight: AppSpacing.spacing40,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: AppSpacing.height14),
            ),
            onChanged: widget.onSearch,
          ),
        ),
      ),
    );
  }
}
