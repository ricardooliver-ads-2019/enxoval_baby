// onboarding/climate_screen.dart
import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_button.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_dropdown.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class ClimateView extends StatefulWidget {
  final ArgsClimateView args;
  const ClimateView({super.key, required this.args});

  @override
  State<ClimateView> createState() => _ClimateViewState();
}

class _ClimateViewState extends State<ClimateView> {
  ClimateEnum selectedClimate = ClimateEnum.tropical;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingIllustration(
              asset: ImageOnboardingLayetteCustomizationPaths.climate.path,
              semanticLabel: 'Ilustração de clima: sol, nuvem e floco de neve',
            ),
            const SizedBox(height: 32),

            // Textos
            const OnboardingTexts(
              title: "Qual o clima predominan na sua região?",
              subtitle:
                  "Nos conte como é o clima na sua região para a lista ser ainda mais assertiva.",
            ),
            const SizedBox(height: 24),

            // Dropdown
            OnboardingDropdown<ClimateEnum>(
              width: double.infinity,
              label: "Clima",
              value: selectedClimate,
              items: List.generate(
                ClimateEnum.values.length,
                (index) => DropdownMenuEntry(
                  value: ClimateEnum.values[index],
                  label: ClimateEnum.values[index].name.toUpperCase(),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedClimate = value);
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: // Botões
          Padding(
        padding: const EdgeInsets.all(24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 16,
          children: [
            Expanded(
              child: OnboardingButton(
                label: "Voltar",
                onPressed: widget.args.previousPage,
                isPrimary: false,
              ),
            ),
            Expanded(
              child: OnboardingButton(
                label: "Avançar",
                onPressed: widget.args.nextPage,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class ArgsClimateView {
  final ValueNotifier<ClimateEnum> climate;
  final void Function() nextPage;
  final void Function() previousPage;

  const ArgsClimateView({
    required this.climate,
    required this.previousPage,
    required this.nextPage,
  });
}

  
