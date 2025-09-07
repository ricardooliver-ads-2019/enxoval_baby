import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/config/navigation/auth_gate_state.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_routes.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/utils/routes/home_enxoval_routes.dart';
import 'package:enxoval_baby/app/presentation/onboarding_layette_customization/utils/onboarding_layette_customization_routes.dart';
import 'package:enxoval_baby/app/presentation/splash/utils/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
final _gate = Injection.inject<AuthGateState>();
class AppRouter {
  static GoRouter get router {
    
    return GoRouter(
      initialLocation: SplashRoutes.splash.path,
      refreshListenable: _gate,
      debugLogDiagnostics: true,
      redirect: _redirect,
      routes: [
        ...SplashRoutes.routes,
        ...AuthRoutes.routes,
        ...OnboardingLayetteCustomizationRoutes.routes,
        ...HomeEnxovalRoutes.routes,
      ],
    );
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final currentPath = state.matchedLocation;
  final isSplash = currentPath == SplashRoutes.splash.path;
  final isPublicRoute = _isPublicRoute(currentPath);

  if (isSplash) {
    return  null;
  }

  if (!_gate.isAuth) {
    return isPublicRoute ? null : AuthRoutes.login.path;
  }

  // Autenticado: pode estar carregando a flag ainda
  final done = _gate.onboardingDone;

  // ⚠️ Enquanto calcula (null), não force bang e não redirecione.
  // Deixe na tela atual; o refreshListenable (_gate) fará o redirect de novo quando atualizar.
  if (done == null) return null;

  // Autenticado
  if (isPublicRoute || isSplash) {
    return done
        ? HomeEnxovalRoutes.homeEnxoval.path
        : OnboardingLayetteCustomizationRoutes.onboardingLayetteCustomizationPageView.path;
  }

  return null;
}

bool _isPublicRoute(String path) {
  return path == AuthRoutes.login.path ||
      path == AuthRoutes.register.path ||
      path == AuthRoutes.forgotPassword.path;
}
