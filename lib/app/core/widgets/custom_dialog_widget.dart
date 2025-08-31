
import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/widgets/alert_dialog_widget.dart';
import 'package:enxoval_baby/app/core/widgets/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class CustomDialogWidget extends StatelessWidget {
  final Widget? header;
  final Widget body;
  final VoidCallback onTapButtonPrimary;
  final VoidCallback onTapButtonSecundary;
  final String? titleButtonPrimary;
  final String? titleButtonSecundary;

  const CustomDialogWidget({
    super.key,
    required this.body,
    required this.onTapButtonSecundary,
    required this.onTapButtonPrimary,
    this.header,
    this.titleButtonPrimary,
    this.titleButtonSecundary,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialogWidget(
      title: header ??
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: context.pop,
              child: Icon(Icons.close, size: DSSpacing.xxbodied.value),
            ),
          ),
      content: body,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        ButtonWidget(
          onPressed: onTapButtonSecundary,
          isPrimary: false,
          label: titleButtonSecundary ?? AppStrings.cancelar.text,
        ),
        DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.xxbodied.value),
        ButtonWidget(
          onPressed: onTapButtonPrimary,
          isPrimary: true,
          label: titleButtonPrimary ?? AppStrings.sim.text,
        )
      ],
    );
  }
}
