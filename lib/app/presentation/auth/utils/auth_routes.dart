import 'package:enxoval_baby/app/presentation/auth/forgot_password/view/forgot_password_screen.dart';
import 'package:enxoval_baby/app/presentation/auth/login/view/login_screen.dart';
import 'package:enxoval_baby/app/presentation/auth/register/view/register_screen.dart';
import 'package:go_router/go_router.dart';

enum AuthRoutes {
  login('login'),
  register('register'),
  forgotPassword('forgotPassword');

  final String routeName;
  const AuthRoutes(this.routeName);

  String get path => '/$routeName';

  static List<GoRoute> routes = [
    GoRoute(
      name: login.routeName,
      path: login.path,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: register.routeName,
      path: register.path,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      name: forgotPassword.routeName,
      path: forgotPassword.path,
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
  ];
}
