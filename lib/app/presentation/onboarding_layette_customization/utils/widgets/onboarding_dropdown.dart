import 'package:flutter/material.dart';

class OnboardingDropdown<T> extends StatelessWidget {
  final T value;
  final String? label;
  final double? width;
  final List<DropdownMenuEntry<T>> items;
  final ValueChanged<T?> onChanged;

  const OnboardingDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.label,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
      initialSelection: value,
      label: label != null ? Text(label!) : null,
      width: width,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      dropdownMenuEntries: items,
      onSelected: onChanged,
    );
  }
}