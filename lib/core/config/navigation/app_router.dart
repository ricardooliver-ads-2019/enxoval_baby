import 'package:enxoval_baby/app/features/home_enxoval/utils/routes/home_enxoval_routes.dart';
import 'package:enxoval_baby/app/features/login/utils/login_routes.dart';
import 'package:enxoval_baby/app/features/splash/utils/splash_routes.dart';
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
        ...HomeEnxovalRoutes.routes,
        ...LoginRoutes.routes,
      ],
    );
  }
}

Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  return null;
}
