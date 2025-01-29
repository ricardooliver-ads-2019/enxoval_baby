import 'package:enxoval_baby/app/features/home_enxoval/home_enxoval_screen.dart';
import 'package:go_router/go_router.dart';

enum HomeEnxovalRoutes {
  homeEnxoval('homeEnxoval');

  final String routeName;
  const HomeEnxovalRoutes(this.routeName);

  String get path => '/$routeName';

  static List<GoRoute> routes = [
    GoRoute(
      name: homeEnxoval.routeName,
      path: homeEnxoval.path,
      builder: (context, state) => const HomeEnxovalScreen(),
    )
  ];
}
