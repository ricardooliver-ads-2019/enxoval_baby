import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_button.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class DueDateView extends StatefulWidget {
  final ArgsDueDateView args;
  const DueDateView({super.key, required this.args});

  @override
  State<DueDateView> createState() => _DueDateViewState();
}

class _DueDateViewState extends State<DueDateView> {
  final _dateController = TextEditingController();
  final _dateFocus = FocusNode();
  DateTime? selectedDate;

  @override
  void dispose() {
    _dateController.dispose();
    _dateFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OnboardingIllustration(
              asset: ImageOnboardingLayetteCustomizationPaths.dueDate.path,
              semanticLabel: 'Ilustração de calendário',
            ),
            const SizedBox(height: 32),

            // Textos
            const OnboardingTexts(
              title: "Qual a data prevista para o parto?",
              subtitle:
                  "Nos conte qual a data prevista para o parto para a lista ser ainda mais assertiva.",
            ),
            const SizedBox(height: 24),

            SizedBox(
              width: double.maxFinite,
              child: DSInputTextFormField(
                
                controller: _dateController,
                focus: _dateFocus,
                label: "Data Prevista",
                hintText: "25/04/2026",
                textInputType: TextInputType.name,
                
                onTap: () async{
                  final result = await showDatePicker(
                    context: context,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (result != null) {
                    selectedDate = result;
                    _dateController.text = selectedDate.toString();
                    setState(() {});
                  }
                },
              
                inputBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12),borderSide: BorderSide(
                  width: 1,
                  color: _dateFocus.hasFocus?DSColors.borderFocus:DSColors.borderDisabled,
                ),),
              ),
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
class ArgsDueDateView {
  final ValueNotifier<DateTime?> dueDate;
  final void Function() nextPage;
  final void Function() previousPage;

  ArgsDueDateView({
    required this.dueDate,
    required this.previousPage,
    required this.nextPage,
  });
}

  
