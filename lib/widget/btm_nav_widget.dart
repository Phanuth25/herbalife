import 'package:flutter/material.dart';
import 'package:project2/data/notifier.dart';

void main() => runApp(ButtomNav());

class ButtomNav extends StatefulWidget {
  const ButtomNav({super.key});

  @override
  State<ButtomNav> createState() => _ButtomNavState();
}

class _ButtomNavState extends State<ButtomNav> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: valueNotifier, builder: (context, value, child) { return NavigationBar(destinations: [NavigationDestination(icon: Icon(Icons.home), label: 'Home'),NavigationDestination(icon: Icon(Icons.person), label: "Profile")],
      onDestinationSelected: (int value){

          valueNotifier.value = value;
      },
      selectedIndex: valueNotifier.value,
    );

    },);

  }
}
