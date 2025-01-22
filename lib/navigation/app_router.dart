import 'package:enxoval_baby/app/features/splash/utils/navigation/splash_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static GoRouter get router {
    return GoRouter(
      initialLocation: SplashRoutes.splash.routeName,
      debugLogDiagnostics: true,
      redirect: _redirect,
      routes: [
        ...SplashRoutes.routes,
      ],
    );
  }
}

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  // if the user is not logged in, they need to login
  // final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  // final loggingIn = state.matchedLocation == Routes.login;
  // if (!loggedIn) {
  //   return Routes.login;
  // }

  // if the user is logged in but still on the login page, send them to
  // the home page
  // if (loggingIn) {
  //   return Routes.home;
  // }

  // no need to redirect at all
  return null;
}
