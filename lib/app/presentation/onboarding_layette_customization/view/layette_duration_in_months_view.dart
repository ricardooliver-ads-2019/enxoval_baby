import 'package:enxoval_baby/app/core/utils/image_paths.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_bottom_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_dropdown.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_illustration.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_texts.dart';
import 'package:flutter/material.dart';

class LayetteDurationInMonthsView extends StatefulWidget {
  final ArgsLayetteDurationInMonthsView args;
  const LayetteDurationInMonthsView(
      {super.key, required this.args});

  @override
  State<LayetteDurationInMonthsView> createState() =>
      _LayetteDurationInMonthsViewState();
}

class _LayetteDurationInMonthsViewState
    extends State<LayetteDurationInMonthsView> {
  int selectedDurationInMonths = 3;
  List<int> durationOptions = [3, 6, 9, 12];

  @override
  void initState() {
    widget.args.layetteDurationInMonths.addListener(() {
      selectedDurationInMonths = widget.args.layetteDurationInMonths.value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            OnboardingIllustration(
              asset: ImageOnboardingLayetteCustomizationPaths
                  .layetteDurationInMonths.path,
              semanticLabel: 'Ilustração de duração da layette em meses',
            ),
            const SizedBox(height: 32),

            // Textos
            const OnboardingTexts(
              title: "Qual a duração do enxoval em meses?",
              subtitle:
                  "Informe para quantos meses você pretende montar o enxoval.",
            ),
            const SizedBox(height: 24),

            // Dropdown
            OnboardingDropdown<int>(
              width: double.infinity,
              label: "Duração do Enxoval",
              value: selectedDurationInMonths,
              items: durationOptions.map((duration) {
                return DropdownMenuEntry(
                  value: duration,
                  label: "$duration meses".toUpperCase(),
                );
              }).toList(),
              onChanged: (value) {
                if (value != null) {
                  setState(() => selectedDurationInMonths = value);
                }
              },
            ),
            const Spacer(),
          ],
        ),
      ),
      bottomNavigationBar: OnboardingBottomBar(
        onBack: widget.args.previousPage,
        onNext: () {
          widget.args.layetteDurationInMonths.value = selectedDurationInMonths;
          widget.args.nextPage();
        },
      ),
    );
  }
}
class ArgsLayetteDurationInMonthsView {
  final ValueNotifier<int> layetteDurationInMonths;
  final void Function() nextPage;
  final void Function() previousPage;

  ArgsLayetteDurationInMonthsView({
    required this.layetteDurationInMonths,
    required this.previousPage,
    required this.nextPage,
  });
}

  