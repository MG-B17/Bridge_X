import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/widgets/v_space.dart';
import '../widgets/empty_state_illustration.dart';
import '../widgets/no_teams_details.dart';

class NoTeamsScreen extends StatelessWidget {
  const NoTeamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: EdgeInsets.all(8.w),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(Icons.arrow_back, color: context.colors.primary, size: 20.sp),
              onPressed: () => context.pop(),
            ),
          ),
        ),
      ),
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
}
