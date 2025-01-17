import 'package:enxoval_baby/app/enxoval_baby_app.dart';
import 'package:enxoval_baby/widgets/item_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const EnxovalBabyApp());
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Baby Registry Items')),
      body: ListView(
        children: [
          ItemCard(
            itemName: 'Trocador de Fralda Portátio',
            amountSpent: 255000000,
            bought: 0,
            total: 1,
            priority: 'Essential',
            progress: 0.5,
            itemIcon: Icons.baby_changing_station_rounded,
            onDetails: () {},
          ),
        ],
      ),
    );
  }
}
