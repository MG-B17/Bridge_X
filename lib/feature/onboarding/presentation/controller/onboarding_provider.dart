import 'package:bridge_x/core/constant/app_keys.dart';
import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/core/init/app_state.dart';
import 'package:bridge_x/core/navigation/route_constant/bridege_x_route_names.dart';
import 'package:bridge_x/core/services/chache_service.dart';
import 'package:bridge_x/feature/onboarding/presentation/model/onboarding_content_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingProvider extends ChangeNotifier {
  final CacheService _cacheService;
  final AppState _appState;

  OnboardingProvider(this._cacheService, this._appState);

  final PageController pageController = PageController();
  int currentPage = 0;
  bool islastPage = false;

  final List<OnboardingContentModel> onboardingContents = [
    OnboardingContentModel(
      title: AppStrings.onboardingTitles[0],
      description: AppStrings.onboardingDescriptions[0],
      image: 'assets/svgs/onboarding1.svg',
    ),
    OnboardingContentModel(
      title: AppStrings.onboardingTitles[1],
      description: AppStrings.onboardingDescriptions[1],
      image: 'assets/svgs/onboarding2.svg',
    ),
    OnboardingContentModel(
      title: AppStrings.onboardingTitles[2],
      description: AppStrings.onboardingDescriptions[2],
      image: 'assets/svgs/onboarding3.svg',
    ),
  ];

  void onPageChanged({required int index}) {
    currentPage = index;
    islastPage = currentPage == onboardingContents.length - 1;
    notifyListeners();
  }

  Future<void> nextPage({required BuildContext context}) async {
    if (currentPage < onboardingContents.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 750),
        curve: Curves.fastEaseInToSlowEaseOut,
      );
    } else {
      await _markOnboardingSeen();
      if (context.mounted) context.goNamed(BridegeXRouteNames.login);
    }
  }

  Future<void> skip({required BuildContext context}) async {
    await _markOnboardingSeen();
    if (context.mounted) context.goNamed(BridegeXRouteNames.login);
  }

  Future<void> _markOnboardingSeen() async {
    await _cacheService.saveData(key: AppKeys.onboardingSeenKey, value: true);
    _appState.hasSeenOnboarding = true;
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}
