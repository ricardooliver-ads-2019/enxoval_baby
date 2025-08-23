import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_button.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class FamilyProfileView extends StatefulWidget {
  final ArgsFamilyProfileView args;
  const FamilyProfileView({ super.key, required this.args });

  @override
  State<FamilyProfileView> createState() => _FamilyProfileViewState();
}

class _FamilyProfileViewState extends State<FamilyProfileView> {
  final _profileController = TextEditingController();
  final _profileFocus = FocusNode();

  @override
  void dispose() {
    _profileController.dispose();
    _profileFocus.dispose();
    super.dispose();
  }

   @override
   Widget build(BuildContext context) {
       return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            OnboardingIllustration(
              asset: ImageOnboardingLayetteCustomizationPaths.familyProfile.path,
              semanticLabel: 'Ilustração de perfil familiar',
            ),
            const SizedBox(height: 32),

            // Textos
            const OnboardingTexts(
              title: "Qual o seu estilo de vida?",
              subtitle:
                  "Fale um pouco sobre você e sua família para que possamos personalizar ainda mais a sua experiência.",
            ),
            const SizedBox(height: 24),
            DSInputTextFormField(
              controller: _profileController,
              focus: _profileFocus,
              label: "Perfil Familiar",
              textInputType: TextInputType.name,
              onChanged: (value) {
                _profileController.text = value!.toUpperCase();
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
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

class ArgsFamilyProfileView {
  final ValueNotifier<String?> familyProfile;
  final void Function() nextPage;
  final void Function() previousPage;

  ArgsFamilyProfileView({
    required this.familyProfile,
    required this.previousPage,
    required this.nextPage,
  });
}