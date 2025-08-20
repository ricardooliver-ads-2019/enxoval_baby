import 'package:flutter/material.dart';

class DueDateView extends StatefulWidget {
  final ValueNotifier<DateTime?> dueDate;
  const DueDateView({ super.key, required this.dueDate });

  @override
  State<DueDateView> createState() => _DueDateViewState();
}

class _DueDateViewState extends State<DueDateView> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text(''),),
           body: Container(),
       );
  }
}