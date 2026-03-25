import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:project2/project/textstyle.dart';
import 'package:project2/project/unit_converter.dart';
import 'package:project2/project/weather.dart';
class Beginner extends StatefulWidget {
  const Beginner({super.key});

  @override
  State<Beginner> createState() => _BeginnerState();
}

class _BeginnerState extends State<Beginner> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.orange.shade500,
            ),

            width: double.infinity,
            height: 500,
            child: Center(
              child: Column(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage(
                        "assets/images/spiderman.jpg",
                      ),
                    ),
                  ),
                  Text("Name: Hang Sophanuth", style: Textstyle.normaltext),
                  Text(
                    "Job Title: Printer & Student",
                    style: Textstyle.normaltext.copyWith(fontSize: 25),
                  ),
                  Builder(
                    builder: (context) {
                      return InkWell(
                        child: Text(
                          "Contact",
                          style: Textstyle.normaltext.copyWith(fontSize: 25),
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text(
                                  "069 803 787",
                                  style: Textstyle.normaltext.copyWith(
                                    fontSize: 25,
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text("Close"),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
          NavigationDestination(
            icon: Icon(Icons.calculate),
            label: "Converter",
          ),
          NavigationDestination(icon: Icon(Icons.cloud), label: "Weather")
        ],
        onDestinationSelected: (value) {
          setState(() {
            index = value;
          });
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Beginner()),
            );
          } else if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Converter()),
            );
          }
          else if(index ==2){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Weather()),
            );
          }
        },
        selectedIndex: index,
      ),
    );
  }
}
