import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jointjam/fixed.dart';
import 'package:jointjam/screens/home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  static String routeName = "/splashRoute";

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  int imageIndex = 0;

  @override
  void initState() {
    super.initState();
    // Start the countdown timer to move to the next screen
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (imageIndex >= imagePaths.length - 1) {
          timer.cancel();
          Navigator.pushReplacementNamed(context, HomeScreen.routeName);
        } else {
          imageIndex++;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: imagePaths[imageIndex]['bg'],
      body: Center(
        child: Image.asset(imagePaths[imageIndex]['img']),
      ),
    );
  }
}
