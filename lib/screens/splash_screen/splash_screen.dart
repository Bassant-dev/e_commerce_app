import 'dart:async';
import 'package:flutter/material.dart';
import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import '../onboarding_screen/onboarding.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
          () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHome(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(flex: 2),
            Image.asset(
              'assets/img/Reading glasses-bro.png',
              width: 400, // Adjust the width as needed
              height: 400, // Adjust the height as needed
            ),
            SizedBox(height: 20), // Add spacing between the image and text
            Text(
              'Books',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Text color
              ),
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}
