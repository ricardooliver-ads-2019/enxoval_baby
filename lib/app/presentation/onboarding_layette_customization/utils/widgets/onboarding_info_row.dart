import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class OnboardingInfoRow extends StatelessWidget {
  const OnboardingInfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    required this.bgColor,
    required this.onEditTap,
  });

  final Widget icon;
  final String title;
  final String value;
  final Color bgColor;
  final VoidCallback onEditTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(12),
          ),
          alignment: Alignment.center,
          child: icon,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: DSTextStyle.caption1(context, cor: DSColors.textGray)
                      .semiStrong),
              const SizedBox(height: 2),
              Text(
                value,
                style: DSTextStyle.body3(context).defaults,
              ),
            ],
          ),
        ),
        
        GestureDetector(
          onTap: onEditTap,
          child: Container(
            width: 35,
            height: 35,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Icon(
              Icons.mode_edit_outline_outlined,
              color: DSColors.primaryVariant,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}
