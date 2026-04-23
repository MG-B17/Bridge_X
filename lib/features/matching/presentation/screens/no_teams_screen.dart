import 'package:flutter/material.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/empty_state_illustration.dart';
import '../widgets/no_teams_details.dart';

class NoTeamsScreen extends StatelessWidget {
  const NoTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: _buildAppBar(context),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: context.spacing.xl),
        child: Column(
          children: [
            const Expanded(flex: 3, child: Center(child: EmptyStateIllustration())),
            Expanded(
              flex: 4,
              child: Column(
                children: const [
                  NoTeamsHeader(),
                  Spacer(),
                  NoTeamsActions(),
                  VSpace(40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: context.colors.primary),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
