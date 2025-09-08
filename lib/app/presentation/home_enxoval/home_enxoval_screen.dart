import 'package:enxoval_baby/app/presentation/auth/logout/view/logout_button.dart';
import 'package:enxoval_baby/app/presentation/home_enxoval/widgets/item_card.dart';
import 'package:flutter/material.dart';

class HomeEnxovalScreen extends StatefulWidget {
  const HomeEnxovalScreen({super.key});

  @override
  State<HomeEnxovalScreen> createState() => _HomeEnxovalScreenState();
}

class _HomeEnxovalScreenState extends State<HomeEnxovalScreen> {
  @override
  void initState() {
    super.initState();
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   debugPrint('▶️ Executando getLocalProfile.execute()');
    //   _vmSplash.getLocalProfile.execute();
    // });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: LogoutButton(),
          ),
        ],
        title: const Text('Baby Registry Items'),
      ),
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
