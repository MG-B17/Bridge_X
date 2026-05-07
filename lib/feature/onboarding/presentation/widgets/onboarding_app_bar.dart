import 'package:bridge_x/core/constant/bridge_x_strings.dart';
import 'package:bridge_x/feature/onboarding/presentation/controller/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class OnboardingAppBar extends StatelessWidget {
  const OnboardingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset('assets/svgs/Bridge_x_name_icon.svg'),
        const Spacer(),
        TextButton(
          onPressed: () =>
              context.read<OnboardingProvider>().skip(context: context),
          child: Text(
            AppStrings.skip,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
