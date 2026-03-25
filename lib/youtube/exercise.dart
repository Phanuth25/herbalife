import 'package:flutter/material.dart';

void main() {
  runApp(const Exercise());
}

class Exercise extends StatelessWidget {
  const Exercise({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [



                  Expanded(flex: 1,child: Container(height: 20,decoration: BoxDecoration(color: Colors.grey),)),
                  Expanded(flex: 2,child: Container(height: 20,decoration: BoxDecoration(color: Colors.teal),)),
                  Expanded(flex: 3,child: Container(height: 20,decoration: BoxDecoration(color: Colors.blue),)),


            ],
          ),
        ),
      ),
    );
  }
}
