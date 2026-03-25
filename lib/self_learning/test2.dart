
import 'package:flutter/material.dart';
import 'package:project2/self_learning/test.dart';

class Test2 extends StatefulWidget {
  const Test2({super.key,required this.type1,});
  final String type1;

  @override
  State<Test2> createState() => _Test2State();
}

class _Test2State extends State<Test2> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home:Scaffold(appBar: AppBar(title: Text(widget.type1),),));
  }
}
