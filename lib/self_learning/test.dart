import 'package:flutter/material.dart';
import 'package:project2/self_learning/test2.dart';
void main() {
  runApp(Test());
}

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  List<String> fruits = ['apple', 'banana', 'pear'];

  bool? isChecked = false;
  bool isSwitched = true;
  double slidervalue = 0;
  List<String> options = ["apple", "banana", "pear"];
  String? dropdownvalue = "apple";
  List<String> option2 = ["men", "women", "other"];
  String? dropdownvalue2 = "men";

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Column(
            children: [
              ElevatedButton(
                child: Text("Click here to send data to another page"),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Test2(type1: "Test2"),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
  }
}
