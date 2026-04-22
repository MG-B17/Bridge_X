import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:bridgex/core/utils/extensions.dart';
import 'package:bridgex/core/navigation/app_route_constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  Future<void> _navigateToNext() async {
    // 1.5 seconds delay
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      // Navigate to root to trigger go_router's redirect guard
      context.go(AppRouteConstant.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.scaffoldBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App logo asset or text fallback
            SvgPicture.asset(
              'assets/svg/Group 1171275954 (1).svg',
              width: 200.w,
              height: 200.w,
              errorBuilder: (context, error, stackTrace) {
                // If logo.png doesn't exist, we fallback to just the icon/text
                return Icon(
                  Icons.groups_rounded,
                  size: 100.w,
                  color: context.colors.primary,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
