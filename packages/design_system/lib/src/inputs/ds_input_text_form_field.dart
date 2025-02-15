import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DSInputTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focus;
  final bool autofocus;
  final bool enabled;
  final bool isLoading;
  final bool showCounterMaxLength;
  final AutovalidateMode? autovalidateMode;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final TextInputType? textInputType;
  final int? maxLength;
  final String? label;
  final String? hintText;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? helperText;

  const DSInputTextFormField({
    super.key,
    required this.controller,
    required this.focus,
    this.autofocus = false,
    this.enabled = true,
    this.autovalidateMode,
    this.maxLength,
    this.isLoading = false,
    this.showCounterMaxLength = true,
    this.label,
    this.hintText,
    this.prefixText,
    this.prefixStyle,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.validator,
    this.textInputType,
    this.suffixIcon,
    this.helperText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: focus,
      builder: (_, __) {
        return TextFormField(
          controller: controller,
          focusNode: focus,
          autofocus: autofocus,
          maxLength: maxLength,
          keyboardType: textInputType,
          inputFormatters: inputFormatters,
          validator: validator,
          enabled: enabled,
          autovalidateMode: autovalidateMode,
          onChanged: onChanged,
          onTap: onTap,
          decoration: InputDecoration(
            filled: !enabled,
            fillColor: _backgroundColor(context),
            counterText: showCounterMaxLength && maxLength != null ? null : '',
            label: label != null
                ? Text(
                    label!,
                  )
                : null,
            hintText: hintText,
            prefixText: prefixText,
            prefixStyle: prefixStyle,
            suffix: suffixIcon,
            prefixIcon: prefixIcon,
            helperText: helperText,
            helperMaxLines: 2,
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: DSColors.borderDisabled,
              ),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: DSColors.borderFocus,
              ),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: DSColors.borderDefault,
              ),
            ),
          ),
        );
      },
    );
  }

  Color? _backgroundColor(BuildContext context) {
    if (!enabled) return DSColors.disabled;
    return null;
  }
}
