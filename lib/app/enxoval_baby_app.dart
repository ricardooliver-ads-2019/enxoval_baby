import 'package:enxoval_baby/app/navigation/router_app.dart';
import 'package:flutter/material.dart';

class EnxovalBabyApp extends StatefulWidget {
  const EnxovalBabyApp({super.key});

  @override
  State<EnxovalBabyApp> createState() => _EnxovalBabyAppState();
}

class _EnxovalBabyAppState extends State<EnxovalBabyApp> {
  final router = RouterApp.router;
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Enxoval Baby',
      routerConfig: router,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
      locale: const Locale('pt', 'BR'),
      supportedLocales: const [Locale('pt', 'BR')],
    );
  }
}
