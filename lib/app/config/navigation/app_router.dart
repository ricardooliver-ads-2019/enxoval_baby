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
  final authRepo = Injection.inject<AuthRepository>();
  final isAuthenticated = authRepo.isAuth.value;
  final currentPath = state.matchedLocation;

  final isSplash = currentPath == SplashRoutes.splash.path;
  final isPublicRoute = _isPublicRoute(currentPath);

  if (isSplash) return null;

  if (!isAuthenticated && !isPublicRoute) {
    return AuthRoutes.login.path;
  }

  if (isAuthenticated && isPublicRoute) {
    return HomeEnxovalRoutes.homeEnxoval.path;
  }

  return null;
}

bool _isPublicRoute(String path) {
  return path == AuthRoutes.login.path ||
      path == AuthRoutes.register.path ||
      path == AuthRoutes.forgotPassword.path;
}
