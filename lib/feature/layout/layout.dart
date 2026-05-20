import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_state.dart';
import 'package:bridge_x/feature/layout/widgets/bridge_x_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key, required this.navigationShell});
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          BlocBuilder<ScrollCubit, ScrollState>(
            builder: (context, state) {
              return Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: IgnorePointer(
                  ignoring: !state.showNavbar,
                  child: AnimatedSlide(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOutCubic,
                    offset: state.showNavbar ? const Offset(0, 0) : const Offset(0, 1),
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: state.showNavbar ? 1 : 0,
                      child: BridgeXBottomNavBar(navigationShell: navigationShell),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
