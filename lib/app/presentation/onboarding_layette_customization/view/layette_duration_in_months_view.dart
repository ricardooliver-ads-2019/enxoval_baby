import 'package:flutter/material.dart';

class LayetteDurationInMonthsView extends StatefulWidget {
  final ValueNotifier<int> layetteDurationInMonths;
  const LayetteDurationInMonthsView({ super.key, required this.layetteDurationInMonths });

  @override
  State<LayetteDurationInMonthsView> createState() => _LayetteDurationInMonthsViewState();
}

class _LayetteDurationInMonthsViewState extends State<LayetteDurationInMonthsView> {
   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}