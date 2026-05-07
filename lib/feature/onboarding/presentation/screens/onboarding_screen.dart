import 'package:bridge_x/core/di/di.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:bridge_x/feature/onboarding/presentation/widgets/onboarding_app_bar.dart';
import 'package:bridge_x/feature/onboarding/presentation/widgets/onboarding_background.dart';
import 'package:bridge_x/feature/onboarding/presentation/widgets/page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<OnboardingProvider>(
      create: (_) => OnboardingProvider(sl<CacheService>()),
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: OnboardingBackground()),
            Positioned(top: 50.h, left: 20.w, right: 20.w, child: const OnboardingAppBar()),
            Positioned.fill(child: PageViewWidget()),
          ],
        ),
      ),
    );
  }
}
