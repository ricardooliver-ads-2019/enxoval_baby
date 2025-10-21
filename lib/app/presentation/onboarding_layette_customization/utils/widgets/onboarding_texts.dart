import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class OnboardingTexts extends StatelessWidget {
  final String title;
  final String subtitle;

  const OnboardingTexts({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: DSTextStyle.subtitle3(context).semiStrong,
        ),
        const SizedBox(height: 8),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: DSTextStyle.body3(context, cor: DSColors.textGray).defaults,
        ),
      ],
    );
  }
}