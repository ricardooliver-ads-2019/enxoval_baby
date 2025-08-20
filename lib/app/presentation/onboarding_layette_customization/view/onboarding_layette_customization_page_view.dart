import 'package:enxoval_baby/app/core/utils/enums/climate_enum.dart';
import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_button.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/widgets/onboarding_progress_bar.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/climate_view.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/due_date_view.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/family_profile_view.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/layette_duration_in_months_view.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/sex_baby_view.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/summary_view.dart';
import 'package:flutter/material.dart';

enum OnboardingLayetteCustomizationPagesEnum {
  sexBabyView,
  dueDateView,
  layetteDurationInMonthsView,
  climateView,
  familyProfileView,
  summaryView,
}

class OnboardingLayetteCustomizationPageView extends StatefulWidget {
  const OnboardingLayetteCustomizationPageView({super.key});

  @override
  State<OnboardingLayetteCustomizationPageView> createState() =>
      _OnboardingLayetteCustomizationPageViewState();
}

class _OnboardingLayetteCustomizationPageViewState
    extends State<OnboardingLayetteCustomizationPageView> {
  final PageController _controller = PageController();
  late final ValueNotifier<String?> _nameBaby;
  late final ValueNotifier<SexBabyEnum> _sexBaby;
  late final ValueNotifier<DateTime?> _dueDate;
  late final ValueNotifier<ClimateEnum> _climate;
  late final ValueNotifier<int> _layetteDurationInMonths;
  late final ValueNotifier<String?> _familyProfile;
  int _currentIndex = 0;

  void _nextPage() {
    FocusScope.of(context).unfocus();
    if (_currentIndex < 4) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    if (_currentIndex == 4) {
      _finishOnboarding();
    }
  }

  Future<void> _previousPage() async {
    FocusScope.of(context).unfocus();
    if (_controller.page! > 0.0) {
      await _controller.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _jumpToPage({
    required int pageIndex,
  }) {
    _controller.jumpToPage(pageIndex);
  }

  void _finishOnboarding() {
    // salvar dados no Firestore/SharedPrefs
    Navigator.pushReplacementNamed(context, "/home");
  }

  @override
  void initState() {
    super.initState();
    _nameBaby = ValueNotifier<String?>(null);
    _sexBaby = ValueNotifier<SexBabyEnum>(SexBabyEnum.indefinido);
    _dueDate = ValueNotifier<DateTime?>(null);
    _climate = ValueNotifier<ClimateEnum>(ClimateEnum.tropical);
    _layetteDurationInMonths = ValueNotifier<int>(6);
    _familyProfile = ValueNotifier<String?>(null);
  }

  @override
  void dispose() {
    _nameBaby.dispose();
    _sexBaby.dispose();
    _dueDate.dispose();
    _climate.dispose();
    _layetteDurationInMonths.dispose();
    _familyProfile.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: OnboardingProgressBar(progress: _currentIndex / OnboardingLayetteCustomizationPagesEnum.values.length),
        ),
        body: PageView(
          controller: _controller,
          physics:
              const NeverScrollableScrollPhysics(), // controle apenas via botões
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: [
            // OnboardingWelcome(),
            SexBabyView(
              args: ArgsSexBabyView(
                sexBaby: _sexBaby,
                nameBaby: _nameBaby,
              ),
            ),
            DueDateView(
              dueDate: _dueDate,
            ),  
            ClimateView(
              climate: _climate,
            ),
            LayetteDurationInMonthsView(
              layetteDurationInMonths: _layetteDurationInMonths,
            ),
            FamilyProfileView(
              familyProfile: _familyProfile,  
            ),
            SummaryView(
                args: ArgsSummaryView(
              layetteProfile: LayetteProfileEntity(
                sexBaby: _sexBaby.value,
                nameBaby: _nameBaby.value,
                dueDate: _dueDate.value,
                climate: _climate.value,
                layetteDurationInMonths: _layetteDurationInMonths.value,
                familyProfile: _familyProfile.value,
              ),
              jumpToPage: _jumpToPage,
            )),
          ],
        ),
        bottomNavigationBar: // Botões
            Row(
          children: [
            Expanded(
              child: OnboardingButton(
                label: "Voltar",
                onPressed: _previousPage,
                isPrimary: false,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: OnboardingButton(
                label: _currentIndex == 4 ? "Concluir" : "Avançar",
                onPressed: _nextPage,
              ),
            ),
          ],
        ));
  }
}
