import 'package:enxoval_baby/app/core/utils/app_strings.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/confirm_dialog_widget.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_bottom_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_info_row.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatefulWidget {
  final ArgsSummaryView args;
  const SummaryView({super.key, required this.args});

  @override
  State<SummaryView> createState() => _SummaryViewState();
}

const Color cardColor = Color.fromARGB(255, 240, 241, 251);

class _SummaryViewState extends State<SummaryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Altura da arte responsiva: até 30% da tela ou 230px (o que for menor)
            final double artHeight = constraints.maxHeight > 0
                ? (constraints.maxHeight * 0.2)
                : 200.0;

            // Reserva um espaço no final para não ficar atrás do bottom bar
            final safeBottom = MediaQuery.of(context).padding.bottom;
            const navBarHeight = 72.0;

            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                  24, 0, 24, 24 + navBarHeight + safeBottom),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  OnboardingIllustration(
                    height: artHeight,
                    asset:
                        ImageOnboardingLayetteCustomizationPaths.summary.path,
                  ),

                  const OnboardingTexts(
                    title: "Tudo pronto para\ncomeçar!",
                    subtitle:
                        "Revise as informações e avance para finalizar sua personalização.",
                  ),
                  const SizedBox(height: 24),

                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset:
                          ImageOnboardingLayetteCustomizationPaths.sexBaby.path,
                    ),
                    title: 'Nome',
                    value: (widget.args.layetteProfile.nameBaby != null &&
                            widget.args.layetteProfile.nameBaby!.isNotEmpty)
                        ? widget.args.layetteProfile.nameBaby!
                        : 'Não definido'.toUpperCase(),
                    onEditTap: () => widget.args.jumpToPage(pageIndex: 0),
                  ),
                  const SizedBox(height: 12),
                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset:
                          ImageOnboardingLayetteCustomizationPaths.summary.path,
                    ),
                    title: 'Sexo',
                    value:
                        widget.args.layetteProfile.sexBaby.name.toUpperCase(),
                        onEditTap: () => widget.args.jumpToPage(pageIndex: 0),
                  ),
                  const SizedBox(height: 12),
                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset:
                          ImageOnboardingLayetteCustomizationPaths.dueDate.path,
                    ),
                    title: 'Data prevista de nascimento',
                    value: widget.args.layetteProfile.dueDate != null
                        ? '${widget.args.layetteProfile.dueDate!.day}/${widget.args.layetteProfile.dueDate!.month}/${widget.args.layetteProfile.dueDate!.year}'
                        : 'Sem definir'.toUpperCase(),
                    onEditTap: () => widget.args.jumpToPage(pageIndex: 1),
                  ),
                  const SizedBox(height: 12),
                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset:
                          ImageOnboardingLayetteCustomizationPaths.climate.path,
                    ),
                    title: 'Clima previsto',
                    value:
                        widget.args.layetteProfile.climate.name.toUpperCase(),
                    onEditTap: () => widget.args.jumpToPage(pageIndex: 2),
                  ),
                  const SizedBox(height: 12),
                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset: ImageOnboardingLayetteCustomizationPaths
                          .layetteDurationInMonths.path,
                    ),
                    title: 'Duração do enxoval',
                    value:
                        '${widget.args.layetteProfile.layetteDurationInMonths} meses'
                            .toUpperCase(),
                    onEditTap: () => widget.args.jumpToPage(pageIndex: 3),
                  ),

                  const SizedBox(height: 12),
                  OnboardingInfoRow(
                    bgColor: cardColor,
                    icon: OnboardingIllustration(
                      height: artHeight,
                      asset: ImageOnboardingLayetteCustomizationPaths
                          .familyProfile.path,
                    ),
                    title: 'Perfil familiar',
                    value: (widget.args.layetteProfile.familyProfile != null &&
                            widget
                                .args.layetteProfile.familyProfile!.isNotEmpty)
                        ? widget.args.layetteProfile.familyProfile!
                        : 'Não informado'.toUpperCase(),
                    onEditTap: () => widget.args.jumpToPage(pageIndex: 4),
                  ),

                  const SizedBox(height: 24),

                  // Mensagem de agradecimento
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Obrigado por confiar no Enxoval Baby ',
                        style: TextStyle(color: Color(0xFF9A9AA0)),
                      ),
                      Icon(Icons.favorite_rounded,
                          size: 16, color: Color.fromARGB(255, 123, 133, 245)),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),

      bottomNavigationBar: OnboardingBottomBar(
        onBack: widget.args.previousPage,
        onNext: () {
          showConfirmDialog(context);
        },
        nextLabel: AppStrings.concluir.text,
      ),
    );
  }

  Future<void> showConfirmDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return ConfirmDialogWidget(
        onTapButtonPrimary: () {
          widget.args.nextPage();
        },
      );
    },
  );
}
}

class ArgsSummaryView {
  final LayetteProfileEntity layetteProfile;
  final void Function({
    required int pageIndex,
  }) jumpToPage;
  final void Function() previousPage;
  final void Function() nextPage;
  ArgsSummaryView({
    required this.layetteProfile,
    required this.jumpToPage,
    required this.previousPage,
    required this.nextPage,
  });
}


