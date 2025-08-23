import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_button.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_dropdown.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class SexBabyView extends StatefulWidget {
  final ArgsSexBabyView args;
  const SexBabyView({super.key, required this.args});

  @override
  State<SexBabyView> createState() => _SexBabyViewState();
}

class _SexBabyViewState extends State<SexBabyView> {
  final _nameBabyController = TextEditingController();
  final _nameBabyFocus = FocusNode();
  SexBabyEnum selectedSex = SexBabyEnum.indefinido;

  @override
  void dispose() {
    _nameBabyController.dispose();
    _nameBabyFocus.dispose();
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
              asset: ImageOnboardingLayetteCustomizationPaths.sexBaby.path,
              semanticLabel: 'Ilustração de sexo do bebê: menino e menina',
            ),
            const SizedBox(height: 32),

            // Textos
            const OnboardingTexts(
              title: "Qual o sexo e o nome do seu bebê?",
              subtitle:
                  "Com essas informações, podemos ser ainda mais assertivos na lista de enxoval para o seu bebê.",
            ),
            const SizedBox(height: 24),

            // Dropdown
            OnboardingDropdown<SexBabyEnum>(
              width: double.infinity,
              label: "Sexo do Bebê",
              value: selectedSex,
              items: List.generate(
                SexBabyEnum.values.length,
                (index) => DropdownMenuEntry(
                  value: SexBabyEnum.values[index],
                  label: SexBabyEnum.values[index].name.toUpperCase(),
                ),
              ),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedSex = value);
                }
              },
            ),
            const SizedBox(height: 16),
            DSInputTextFormField(
              controller: _nameBabyController,
              focus: _nameBabyFocus,
              label: "Nome do Bebê",
              textInputType: TextInputType.name,
              onChanged: (value) {
                _nameBabyController.text = value!.toUpperCase();
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

class ArgsSexBabyView {
  final ValueNotifier<SexBabyEnum> sexBaby;
  final ValueNotifier<String?> nameBaby;
  final void Function() nextPage;
  final void Function() previousPage;

  ArgsSexBabyView({
    required this.sexBaby,
    required this.nameBaby,
    required this.previousPage,
    required this.nextPage,
  });
}
