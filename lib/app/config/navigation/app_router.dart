import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/presentation/auth/utils/auth_routes.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/utils/routes/home_enxoval_routes.dart';
import 'package:enxoval_baby/app/presentation/splash/utils/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: SplashRoutes.splash.routeName,
      refreshListenable: Injection.inject<AuthRepository>().isAuth,
      debugLogDiagnostics: true,
      redirect: _redirect,
      routes: [
        ...SplashRoutes.routes,
        ...HomeEnxovalRoutes.routes,
        ...AuthRoutes.routes,
      ],
    );
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final isAuthenticated = Injection.inject<AuthRepository>().isAuth.value;
  final isLoginRoute = state.matchedLocation == AuthRoutes.login.path;
  final isRegisterRoute = state.matchedLocation == AuthRoutes.register.path;

  final isForgotPasswordRoute =
      state.matchedLocation == AuthRoutes.forgotPassword.path;

  if (state.matchedLocation != SplashRoutes.splash.path) {
    if (!isAuthenticated) {
      if (!isLoginRoute && !isRegisterRoute && !isForgotPasswordRoute) {
        return AuthRoutes.login.path;
      }
    } else {
      if (isLoginRoute || isRegisterRoute) {
        return HomeEnxovalRoutes.homeEnxoval.path;
      }
    }
  }

  return null;
}
