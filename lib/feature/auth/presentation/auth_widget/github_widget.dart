import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class GithubWidget extends StatelessWidget {
  const GithubWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset("assets/svgs/github_icon.svg",);
  }
}
