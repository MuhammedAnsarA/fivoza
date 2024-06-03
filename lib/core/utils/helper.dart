import 'package:flutter/material.dart';

class Helper {
  static double screeHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screeWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
