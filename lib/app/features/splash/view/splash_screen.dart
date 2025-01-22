import 'package:enxoval_baby/app/utils/image_paths.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.max,
        children: [
          Image.asset(
            ImagePaths.pregnant.path,
            fit: BoxFit.cover,
            height: MediaQuery.sizeOf(context).height * 0.6,
          ),
        ],
      ),
    );
  }
}
