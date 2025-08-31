import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_bottom_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class FamilyProfileView extends StatefulWidget {
  final ArgsFamilyProfileView args;
  const FamilyProfileView({super.key, required this.args});

  @override
  State<FamilyProfileView> createState() => _FamilyProfileViewState();
}

class _FamilyProfileViewState extends State<FamilyProfileView> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final _profileController = TextEditingController();
  final _profileFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _profileController.text = widget.args.familyProfile.value ?? '';
  }

  @override
  void dispose() {
    _profileController.dispose();
    _profileFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Scaffold(
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
              const OnboardingTexts(
                title: "Qual o seu estilo de vida?",
                subtitle: "Fale um pouco sobre você e sua família para que possamos personalizar ainda mais a sua experiência.",
              ),
              const SizedBox(height: 24),
              DSInputTextFormField(
                controller: _profileController,
                focus: _profileFocus,
                label: "Perfil Familiar",
                textInputType: TextInputType.name,
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1,
                    color: _profileFocus.hasFocus
                        ? DSColors.borderFocus
                        : DSColors.borderDisabled,
                  ),
                ),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return genericValidator(value, 5);
                  }
                  return null;
                },
              ),
              const Spacer(),
            ],
          ),
        ),
        bottomNavigationBar: OnboardingBottomBar(
          onBack: widget.args.previousPage,
          onNext: () {
            if (_formKey.currentState!.validate()) {
              widget.args.familyProfile.value = _profileController.text.toUpperCase();
              widget.args.nextPage();
            }
          },
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