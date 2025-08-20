// onboarding/climate_screen.dart
import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_dropdown.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_progress_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class ClimateView extends StatefulWidget {
  final ValueNotifier<ClimateEnum> climate;
  const ClimateView({super.key, required this.climate});

  @override
  State<ClimateView> createState() => _ClimateViewState();
}

class _ClimateViewState extends State<ClimateView> {
  String selectedClimate = "Quente";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const OnboardingProgressBar(progress: 0.25),
              const SizedBox(height: 32),

              // Imagem ilustrativa
               OnboardingIllustration(
                asset: ImageOnboardingLayetteCustomizationPaths.climate.path,
                semanticLabel:
                    'Ilustração de clima: sol, nuvem e floco de neve',
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
              OnboardingDropdown(
                value: selectedClimate,
                items: const ["Quente", "Frio", "Temperado"],
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
      ),
    );
  }
}
