import 'package:go_router/go_router.dart';

class RouterApp {
  static GoRouter get router {
    return GoRouter(
        initialLocation: '/', debugLogDiagnostics: true, routes: []);
  }
}
