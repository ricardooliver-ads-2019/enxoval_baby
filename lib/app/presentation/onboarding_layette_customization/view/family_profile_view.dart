import 'package:flutter/material.dart';

class FamilyProfileView extends StatefulWidget {
  final ValueNotifier<String?> familyProfile;
  const FamilyProfileView({ super.key, required this.familyProfile });

  @override
  State<FamilyProfileView> createState() => _FamilyProfileViewState();
}

class _FamilyProfileViewState extends State<FamilyProfileView> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}