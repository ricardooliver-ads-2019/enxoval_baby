import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class ActionButtonWidget extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String text;
  final double? verticalPadding;
  final double? borderRadius;

  const ActionButtonWidget({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.text,
    this.verticalPadding,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            vertical: verticalPadding ?? DSSpacing.xxsmall.value,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              borderRadius ?? DSBorderRadius.medium.value,
            ),
          ),
        ),
        child: isLoading ? const CircularProgressIndicator() : Text(text),
      ),
    );
  }
}
