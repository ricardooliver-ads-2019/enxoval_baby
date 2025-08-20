import 'package:enxoval_baby/app/domain/entities/layette_profile_entity.dart';
import 'package:flutter/material.dart';

class SummaryView extends StatefulWidget {
  final ArgsSummaryView args;
  const SummaryView({ super.key, required this.args });

  @override
  State<SummaryView> createState() => _SummaryViewState();
}



class _SummaryViewState extends State<SummaryView> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}

class ArgsSummaryView {
  final LayetteProfileEntity layetteProfile;
  final void Function({
    required int pageIndex,
  }) jumpToPage;
  ArgsSummaryView({required this.layetteProfile, required this.jumpToPage,});
}