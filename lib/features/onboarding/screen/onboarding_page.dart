
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/navigation/app_route_constant.dart';
import '../../../core/utils/extensions.dart';
import '../models/onboarding_slide.dart';
import '../widgets/onboarding_app_bar.dart';
import '../widgets/onboarding_slide_content.dart';
import '../widgets/onboarding_controls.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingSlide> _slides = [
    OnboardingSlide(
      title: 'Find Your Team',
      subtitle: 'Join developers based on your skills and goals. Collaborative building starts here.',
      image: "assets/svg/onboarding_1.svg",
      cardStyle: SlideCardStyle.shadow,
    ),
    OnboardingSlide(
      title: 'Build Real Projects',
      subtitle: 'Work on real-world projects to grow your portfolio.',
      image: "assets/svg/onboarding_2.svg",
      cardStyle: SlideCardStyle.none,
    ),
    OnboardingSlide(
      title: 'Grow Together',
      subtitle: 'Learn, collaborate, and improve faster as a team.',
      image: "assets/svg/onboardig_3.svg",
      cardStyle: SlideCardStyle.bordered,
    ),
  ];

  void _finishOnboarding()  {
      context.go(AppRouteConstant.login);
  }

  void _nextPage() {
    if (_currentIndex < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _finishOnboarding();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: context.colors.scaffoldBg,
        body: SafeArea(
          child: Column(
            children: [
              OnboardingAppBar(onSkip: _finishOnboarding),
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemCount: _slides.length,
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return OnboardingSlideContent(
                      title: slide.title,
                      subtitle: slide.subtitle,
                      image: slide.image,
                      cardStyle: slide.cardStyle,
                    );
                  },
                ),
              ),
              
              OnboardingControls(
                pageController: _pageController,
                totalSlides: _slides.length,
                currentIndex: _currentIndex,
                onNext: _nextPage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
