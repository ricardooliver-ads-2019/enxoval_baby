import 'package:enxoval_baby/widgets/item_card.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
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
            onDetails: () {
              print('View Details');
            },
          ),
          // Add more ItemCards here
        ],
      ),
    );
  }
}
