import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color primaryColor = Color(0xFF0047CC);
  static const Color secondaryColor = Color(0xFF0A557A);
  static const Color backgroundColor = Color(0xFFF5FCFF);
  static const Color textGreyColor = Color(0xFF6B7280);
  static const Color green = Colors.green;
  static const Color white = Colors.white;
  static const Color grey = Colors.grey;

  // Text Styles
  static const TextStyle titleStyle = TextStyle(
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.0,
    letterSpacing: 0,
    color: primaryColor,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    height: 22 / 18,
    letterSpacing: 0,
    color: white,
  );

  static const TextStyle linkTextStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: primaryColor,
  );

  static const TextStyle greyTextStyle = TextStyle(
    color: textGreyColor,
    fontSize: 14,
  );

  // Input Decoration
  static InputDecoration inputDecoration({required String labelText}) {
    return InputDecoration(
      labelText: labelText,
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: grey),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(color: primaryColor),
      ),
      filled: true,
      fillColor: white,
    );
  }

  // Button Style
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: primaryColor,
    foregroundColor: white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0,
    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 24),
    minimumSize: const Size(double.infinity, 50),
  );
}
