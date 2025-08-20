import 'package:enxoval_baby/app/core/utils/enums/sex_baby_enum.dart';
import 'package:flutter/material.dart';

class SexBabyView extends StatefulWidget {
  final ArgsSexBabyView args;
  const SexBabyView({super.key, required this.args});

  @override
  State<SexBabyView> createState() => _SexBabyViewState();
}

class _SexBabyViewState extends State<SexBabyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Container(),
    );
  }
}

class ArgsSexBabyView {
  final ValueNotifier<SexBabyEnum> sexBaby;
  final ValueNotifier<String?> nameBaby;

  ArgsSexBabyView({required this.sexBaby, required this.nameBaby});
}
