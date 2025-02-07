import 'package:enxoval_baby/app/presentation/login/view/login_screen.dart';
import 'package:go_router/go_router.dart';

enum LoginRoutes {
  login('login');

  final String routeName;
  const LoginRoutes(this.routeName);

  String get path => '/$routeName';

  static List<GoRoute> routes = [
    GoRoute(
      name: login.routeName,
      path: login.path,
      builder: (context, state) => const LoginScreen(),
    )
  ];
}
