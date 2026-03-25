import 'package:flutter/material.dart';
import 'package:project2/project/beginner/personal business card app.dart';
import 'package:provider/provider.dart';
import 'package:project2/auth_provider.dart';
void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => AuthProvider(),
    child: Main(),
  ),
);

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, brightness: Brightness.dark),

      ),
      home: Scaffold(body: Beginner()),
    );
  }
}
