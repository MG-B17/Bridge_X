enum SlideCardStyle {
  shadow,
  none,
  bordered,
}

class OnboardingSlide {
  final String title;
  final String subtitle;
  final String image;
  final SlideCardStyle cardStyle;

  OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.image,
    this.cardStyle = SlideCardStyle.shadow,
  });
}
