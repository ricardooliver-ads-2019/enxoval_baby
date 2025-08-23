import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/view/onboarding_layette_customization_page_view.dart';
import 'package:go_router/go_router.dart';

enum OnboardingLayetteCustomizationRoutes {
  onboardingLayetteCustomizationPageView('onboarding-layette-customization');

  final String routeName;

  const OnboardingLayetteCustomizationRoutes(this.routeName);

  String get path => '/$routeName';

  static List<GoRoute> routes = [
    GoRoute(
      name: onboardingLayetteCustomizationPageView.routeName,
      path: onboardingLayetteCustomizationPageView.path,
      builder: (context, state) => const OnboardingLayetteCustomizationPageView(),
    ),
  ];
}