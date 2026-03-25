import 'package:flutter/material.dart';

class Textstyle {
  static const TextStyle normaltext = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
}

class ElevatedButtonStyle {
  static final styleFrom = ElevatedButton.styleFrom(
    backgroundColor: Colors.orange,
    foregroundColor: Colors.white,
    textStyle: Textstyle.normaltext.copyWith(fontSize: 15),
  );
}

class Textfield extends StatelessWidget {
  final TextEditingController textController;

  const Textfield({super.key, required this.textController});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textController,
      style: Textstyle.normaltext.copyWith(color: Colors.orange, fontSize: 20),
      decoration: InputDecoration(
        hintText: "Enter the KM...",
        hintStyle: Textstyle.normaltext.copyWith(
          color: Colors.orange,
          fontSize: 20,
        ),
        prefixIcon: Icon(Icons.calculate, color: Colors.orange),
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Colors.orange),
          borderRadius: BorderRadius.circular(20),
        ),
        filled: true,
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }
}
