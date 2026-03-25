import 'package:flutter/material.dart';
import 'package:project2/self_learning/app1/messenger.dart';
import 'package:project2/self_learning/app1/profile.dart';
void main() => runApp(MaterialApp(home: Myapp(),));

class Myapp extends StatefulWidget {
  @override
  State<Myapp> createState() => _MyappState();
}

class _MyappState extends State<Myapp> {
  List<Widget> pages = [Myapp(),Messenger(),Profile()];

   int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Map"),centerTitle: true,),
      body: pages[index],
      bottomNavigationBar: NavigationBar(destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(icon: Icon(Icons.search), label: "Profile"),
        NavigationDestination(icon: Icon(Icons.message), label: "Messenger")
      ],
        onDestinationSelected: (value) {
        setState(() {
          index = value;
          if(index == 0){
            Navigator.push(context, MaterialPageRoute(builder: (context) => Myapp()));

          }
        });
      }
        ,
      selectedIndex: index,),
    );
  }
}
