import 'package:enxoval_baby/app/config/injector/injection.dart';
import 'package:enxoval_baby/app/domain/repositories/auth_repository.dart';
import 'package:enxoval_baby/app/presentation/auth/login/utils/login_routes.dart';
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
        ...LoginRoutes.routes,
      ],
    );
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final isAuthenticated = Injection.inject<AuthRepository>().isAuth.value;
  final isLoginRoute = state.matchedLocation == LoginRoutes.login.path;
  if (state.matchedLocation != SplashRoutes.splash.path) {
    if (!isAuthenticated) {
      return isLoginRoute ? null : LoginRoutes.login.path;
    }

    if (isLoginRoute) {
      return HomeEnxovalRoutes.homeEnxoval.path;
    }
  }

  return null;
}
