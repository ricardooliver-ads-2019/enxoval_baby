import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';

class OnboardingBottomBar extends StatelessWidget {
  const OnboardingBottomBar({
    super.key,
    required this.onBack,
    required this.onNext,
    this.backLabel,
    this.nextLabel,
    this.padding = const EdgeInsets.all(24),
    this.spacing = 16,
    this.isNextPrimary = true,
  });

  final VoidCallback onBack;
  final VoidCallback onNext;

  final String? backLabel;
  final String? nextLabel;

  final EdgeInsets padding;
  final double spacing;
  final bool isNextPrimary;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ButtonWidget(
              label: backLabel ?? AppStrings.voltar.text,
              onPressed: onBack,
              isPrimary: false,
            ),
          ),
          SizedBox(width: spacing),
          Expanded(
            child: ButtonWidget(
              label: nextLabel ?? AppStrings.avancar.text,
              isPrimary: isNextPrimary,
              onPressed: onNext,
            ),
          ),
        ],
      ),
    );
  }
}
