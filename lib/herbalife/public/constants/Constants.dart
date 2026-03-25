import 'package:flutter/material.dart';

// Colors
const Color kPrimaryGreen = Color(0xFF2E6A38);

// Text Styles
const TextStyle kTitleStyle = TextStyle(
  color: kPrimaryGreen,
  fontWeight: FontWeight.bold,
  fontSize: 20,
);

const TextStyle kHintStyle = TextStyle(
  fontWeight: FontWeight.bold,
);

// TextField Decoration Builder
InputDecoration kTextFieldDecoration({required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: kHintStyle,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: kPrimaryGreen, width: 3.0),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: const BorderSide(color: kPrimaryGreen, width: 3.5),
    ),
  );
}

// Button Style
final ButtonStyle kButtonStyle = ElevatedButton.styleFrom(
  backgroundColor: kPrimaryGreen,
  foregroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10),
  ),
  minimumSize: const Size(200, 50),
);