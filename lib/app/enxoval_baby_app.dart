import 'package:enxoval_baby/navigation/app_router.dart';
import 'package:flutter/material.dart';

class EnxovalBabyApp extends StatefulWidget {
  const EnxovalBabyApp({super.key});

  @override
  State<EnxovalBabyApp> createState() => _EnxovalBabyAppState();
}

class _EnxovalBabyAppState extends State<EnxovalBabyApp> {
  final router = AppRouter.router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Enxoval Baby',
      // locale: const Locale('pt', 'BR'),
      // supportedLocales: const [Locale('pt', 'BR')],
      routerConfig: router,
      // routeInformationParser: router.routeInformationParser,
      // routeInformationProvider: router.routeInformationProvider,
      // routerDelegate: router.routerDelegate,
    );
  }
}
