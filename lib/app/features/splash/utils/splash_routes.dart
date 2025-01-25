import 'package:enxoval_baby/app/features/splash/view/splash_screen.dart';
import 'package:go_router/go_router.dart';

enum SplashRoutes {
  splash('/');

  final String routeName;
  const SplashRoutes(this.routeName);

  String get path => routeName;

  static List<GoRoute> routes = [
    GoRoute(
      name: splash.routeName,
      path: splash.path,
      builder: (context, state) => const SplashScreen(),
    ),
  ];
}
