import 'package:enxoval_baby/app/core/config/navigation/app_router.dart';
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
      routerConfig: router,
    );
  }
}
