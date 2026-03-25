import 'package:flutter/material.dart';
import 'package:project2/data/notifier.dart';
import 'package:project2/widget/btm_nav_widget.dart';
import 'package:project2/public/view/home.dart';
import 'package:project2/public/view/profile.dart';

class WidgetTree extends StatefulWidget {
  const WidgetTree({super.key});

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {

  List<Widget> pages = [Home(),Profile()];
  @override

  Widget build(BuildContext context) {

    return Scaffold(

        appBar: AppBar(title: Text("Flutter app",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30),),centerTitle: true,),
        body: ValueListenableBuilder(valueListenable: valueNotifier, builder: (context, value, child) =>
        pages[valueNotifier.value],),
        bottomNavigationBar: ButtomNav());
  }
}

