import 'package:bridge_x/core/animation/bottom_nav_bar_animation/controller/scroll_cubit.dart';
import 'package:bridge_x/core/widget/buttons/bridge_x_back_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ProjectDetailsBackHeader extends StatelessWidget {
  const ProjectDetailsBackHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: BridgeXBackButton(
        onTap: (){
          context.read<ScrollCubit>().show();
          context.pop();
        },
      ),
    );
  }
}
