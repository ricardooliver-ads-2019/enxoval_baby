import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DSInputPassword extends StatefulWidget {
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

  const DSInputPassword({
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
  State<DSInputPassword> createState() => _DSInputPasswordState();
}

class _DSInputPasswordState extends State<DSInputPassword> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.focus,
      builder: (_, __) {
        return TextFormField(
          controller: widget.controller,
          focusNode: widget.focus,
          autofocus: widget.autofocus,
          maxLength: widget.maxLength,
          keyboardType: widget.textInputType,
          inputFormatters: widget.inputFormatters,
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          onChanged: widget.onChanged,
          onTap: widget.onTap,
          enabled: widget.enabled,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            filled: !widget.enabled,
            fillColor: _backgroundColor(context),
            counterText: widget.showCounterMaxLength && widget.maxLength != null
                ? null
                : '',
            label: widget.label != null
                ? Text(
                    widget.label!,
                  )
                : null,
            hintText: widget.hintText,
            prefixText: widget.prefixText,
            prefixStyle: widget.prefixStyle,
            suffixIcon: _buttonShowHidePassword(context),
            prefixIcon: widget.prefixIcon,
            helperText: widget.helperText,
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
    if (!widget.enabled) return DSColors.disabled;
    return null;
  }

  Widget _buttonShowHidePassword(BuildContext context) {
    return IconButton(
      icon: Icon(
        _obscurePassword ? Icons.visibility_off : Icons.visibility,
      ),
      onPressed: () {
        setState(() {
          _obscurePassword = !_obscurePassword;
        });
      },
    );
  }
}
