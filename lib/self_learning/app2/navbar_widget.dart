import 'package:flutter/material.dart';
import 'package:project2/self_learning/app2/notifer_widget.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: selectednotifier3,
      builder: (context, int value, child) {
        return NavigationBar(
          destinations: const [
            NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
            NavigationDestination(icon: Icon(Icons.message), label: 'Messenger'),
          ],
          onDestinationSelected: (index) {
            selectednotifier3.value = index;
          },
          selectedIndex: value,
        );
      },
    );
  }
}
