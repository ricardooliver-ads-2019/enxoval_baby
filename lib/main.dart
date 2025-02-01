import 'package:enxoval_baby/app/enxoval_baby_app.dart';
import 'package:enxoval_baby/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const EnxovalBabyApp());
}
