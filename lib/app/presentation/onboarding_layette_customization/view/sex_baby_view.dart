import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_bottom_bar.dart';
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

class _SexBabyViewState extends State<SexBabyView> with ValidationsMixin {
  final _nameBabyController = TextEditingController();
  final _nameBabyFocus = FocusNode();
  SexBabyEnum selectedSex = SexBabyEnum.indefinido;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameBabyController.text = widget.args.nameBaby.value ?? '';
    selectedSex = widget.args.sexBaby.value;
  }

  @override
  void dispose() {
    _nameBabyController.dispose();
    _nameBabyFocus.dispose();
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
              SizedBox(
                height: 56,
                child: OnboardingDropdown<SexBabyEnum>(
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
              ),
              const SizedBox(height: 16),
              DSInputTextFormField(
                controller: _nameBabyController,
                focus: _nameBabyFocus,
                label: "Nome do Bebê",
                textInputType: TextInputType.name,
                inputBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    width: 1,
                    color: _nameBabyFocus.hasFocus
                        ? DSColors.borderFocus
                        : DSColors.borderDisabled,
                  ),
                ),
                validator: (value) {
                  if (value!.isNotEmpty) {
                    return genericValidator(value);
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
              widget.args.nameBaby.value = _nameBabyController.text.toUpperCase();
              widget.args.sexBaby.value = selectedSex;
              widget.args.nextPage();
            }
          },
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
