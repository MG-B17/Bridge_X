import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/di/di.dart';
import 'package:flutter/material.dart';


class ScrollNavListener extends StatefulWidget {
  final Widget child;
  final ScrollController controller;

  const ScrollNavListener({
    super.key,
    required this.child,
    required this.controller,
  });

  @override
  State<ScrollNavListener> createState() => _ScrollNavListenerState();
}

class _ScrollNavListenerState extends State<ScrollNavListener> {
  final ScrollCubit cubit = sl<ScrollCubit>();

  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onScroll);
  }

  @override
  void didUpdateWidget(ScrollNavListener oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller.removeListener(_onScroll);
      widget.controller.addListener(_onScroll);
    }
  }

  void _onScroll() {
    if (!widget.controller.hasClients) return;

    final offset = widget.controller.offset;

    if (offset > _lastOffset && offset > 40) {
      cubit.hide();
    } else if (offset <= 150) {
      cubit.show();
    }

    _lastOffset = offset;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onScroll);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}