import 'package:fivoza/core/utils/helper.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image(
          image: const AssetImage('assets/images/logo.png'),
          height: Helper.screenHeight(context) * 0.25,
          width: Helper.screenWidth(context) * 0.25,
        ),
      ),
    );
  }
}
