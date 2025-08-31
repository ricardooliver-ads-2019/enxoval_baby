import 'package:design_system/design_system.dart';
import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/core/utils/validators/validations_mixin.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_bottom_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DueDateView extends StatefulWidget {
  final ArgsDueDateView args;
  const DueDateView({super.key, required this.args});

  @override
  State<DueDateView> createState() => _DueDateViewState();
}

class _DueDateViewState extends State<DueDateView> with ValidationsMixin {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  final _dateFocus = FocusNode();
  DateTime? selectedDate;

  String _formatBR(DateTime date) =>
      DateFormat('dd/MM/yyyy', 'pt_BR').format(date);

  @override
  void initState() {
    if (widget.args.dueDate.value != null) {
      selectedDate = widget.args.dueDate.value;
      _dateController.text = _formatBR(selectedDate!);
    }

    super.initState();
  }

  @override
  void dispose() {
    _dateController.dispose();
    _dateFocus.dispose();
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

                DSInputTextFormField(
                  readOnly: true,
                  controller: _dateController,
                  focus: _dateFocus,
                  label: "Data Prevista",
                  hintText: "25/04/2026",
                  textInputType: TextInputType.name,
                  onTap: () async {
                    final result = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                    );
                    if (result != null) {
                      selectedDate = result;
                      _dateController.text = _formatBR(selectedDate!);
                      setState(() {});
                    }
                  },
                  inputBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      width: 1,
                      color: _dateFocus.hasFocus
                          ? DSColors.borderFocus
                          : DSColors.borderDisabled,
                    ),
                  ),
                  validator: (value) {
                    if (_dateController.text.isNotEmpty) {
                      return dueDateValidator(selectedDate);
                      
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
              if (_formKey.currentState?.validate() ?? false) {
                widget.args.dueDate.value = selectedDate;
                widget.args.nextPage();
              }
            },
          )),
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
