// onboarding/widgets/onboarding_illustration.dart
import 'package:flutter/material.dart';

class OnboardingIllustration extends StatelessWidget {
  final String asset;
  final double? height;
  final double? width;
  final BoxFit fit;
  final String? semanticLabel;
  final EdgeInsetsGeometry padding;
  final Object? heroTag;

  const OnboardingIllustration({
    super.key,
    required this.asset,
    this.height,
    this.width,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.padding = const EdgeInsets.symmetric(vertical: 12),
    this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = Image.asset(
      asset,
      height: height,
      width: width,
      fit: fit,
      semanticLabel: semanticLabel,
    );

    if (semanticLabel != null) {
      child = Semantics(label: semanticLabel, child: child);
    }
    if (heroTag != null) {
      child = Hero(tag: heroTag!, child: child);
    }

    return Padding(padding: padding, child: child);
  }
}

