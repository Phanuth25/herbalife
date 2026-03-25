import "package:flutter/material.dart";
import 'package:project2/self_learning/app2/profile.dart';
import "package:project2/self_learning/app2/message.dart";
import 'package:project2/self_learning/app2/navbar_widget.dart';
import "package:project2/self_learning/app2/notifer_widget.dart";

void main() => runApp(WidgetTree());

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  List<Widget> pages = [Profile(), Messsage()];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isdarkmode,
      builder: (context, value, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.teal,
              brightness: isdarkmode.value ? Brightness.dark : Brightness.light,
            ),
          ),
          home: ValueListenableBuilder(
            valueListenable: selectednotifier3,
            builder: (context, value, child) {
              return Scaffold(
                appBar: AppBar(
                  title: Text("Flutter App"),
                  centerTitle: true,
                  actions: [
                    IconButton(
                      onPressed: () {
                        isdarkmode.value = !isdarkmode.value;
                      },
                      icon: ValueListenableBuilder(
                        valueListenable: isdarkmode,
                        builder: (context, value, child) {

                          return isdarkmode.value? Icon(Icons.dark_mode) : Icon(Icons.light_mode);
                        }
                      ),
                    ),
                  ],
                ),
                body: Container(child: Center(child: pages[value])),
                bottomNavigationBar: Navbar(),
              );
            },
          ),
        );
      },
    );
  }
}
