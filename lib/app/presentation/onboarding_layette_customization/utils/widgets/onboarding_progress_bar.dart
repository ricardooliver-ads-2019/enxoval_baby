import 'package:flutter/material.dart';

class OnboardingProgressBar extends StatelessWidget {
  final double progress; // 0.0 até 1.0

  const OnboardingProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      value: progress,
      minHeight: 4,
      backgroundColor: Colors.grey.shade300,
      valueColor: const AlwaysStoppedAnimation<Color>(Colors.deepPurple),
    );
  }
}