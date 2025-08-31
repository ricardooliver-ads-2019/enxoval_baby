import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ConfirmDialogWidget extends StatelessWidget {
  final VoidCallback onTapButtonPrimary;
  const ConfirmDialogWidget({super.key, required this.onTapButtonPrimary});
  @override
  Widget build(BuildContext context) {
    return CustomDialogWidget(
      header: Row(
        children: [
          Expanded(
            child: Text(
              'Confirmar informações',
              style: DSTextStyle.body2(
                context,
              ).semiStrong,
              textAlign: TextAlign.center,
            ),
          ),
          GestureDetector(
            onTap: context.pop,
            child: const Icon(
              Icons.close,
              size: 24,
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.giant.value),
          Icon(
            Icons.warning_amber_rounded,
            color: DSColors.alertWarning,
            size: 80,
          ),
          DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.xsmall.value),
          Center(
            child: Text(
              'Você confirma que as informações estão corretas?',
              style: DSTextStyle.subtitle3(
                context,
              ).semiStrong,
              textAlign: TextAlign.center,
            ),
          ),
          DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.xsmall.value),
          Center(
            child: Text(
              'A partir delas vamos gerar uma lista de enxoval personalizada para você.',
              style: DSTextStyle.body1(
                context,
              ).defaults,
              textAlign: TextAlign.center,
            ),
          ),
          DSSizedBoxSpacing.sizedBoxVertical(DSSpacing.giant.value),
        ],
      ),
      titleButtonPrimary: AppStrings.concluir.text,
      onTapButtonPrimary:onTapButtonPrimary,
      titleButtonSecundary: AppStrings.cancelar.text,
      onTapButtonSecundary: () {
        context.pop();
      },
    );
  }
}
