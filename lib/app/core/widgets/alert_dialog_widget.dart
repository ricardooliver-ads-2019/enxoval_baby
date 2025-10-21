import 'package:design_system/design_system.dart';
import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  /// Widget - Titulo do dialog
  final Widget? title;

  /// Widget - Conteúdo do dialog
  final Widget? content;

  /// List<Widget> - Lista de ações do dialog
  final List<Widget>? actions;

  final EdgeInsetsGeometry? actionsPadding;

  final MainAxisAlignment actionsAlignment;

  final EdgeInsetsGeometry? contentPadding;

  const AlertDialogWidget({
    super.key,
    this.title,
    this.actions,
    this.content,
    this.actionsPadding,
    this.actionsAlignment = MainAxisAlignment.end,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        side: const BorderSide(color: DSColors.neutralWhite),
        borderRadius: BorderRadius.all(
          Radius.circular(DSBorderRadius.defaults.value),
        ),
      ),
      backgroundColor:
          MediaQuery.of(context).platformBrightness == Brightness.dark
              ? DSColors.neutralBlack
              : DSColors.neutralWhite,
      elevation: 8,
      title: title,
      titleTextStyle: DSTextStyle.body2(
        context,
      ).neutral,
      content: content,
      contentPadding: contentPadding ??
          EdgeInsets.symmetric(
            horizontal: DSSpacing.xxbodied.value,
            vertical: DSSpacing.micro.value,
          ),
      actions: actions,
      actionsOverflowDirection: VerticalDirection.down,
      actionsOverflowAlignment: OverflowBarAlignment.center,
      actionsPadding: actionsPadding ??
          EdgeInsets.all(
            DSSpacing.xxbodied.value,
          ),
      actionsAlignment: actionsAlignment,
      scrollable: true,
    );
  }
}
