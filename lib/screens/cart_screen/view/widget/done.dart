import 'package:flutter/material.dart';

class Done extends StatelessWidget {
  const Done({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     body: Center(
       child: Image.asset(
         'assets/img/Done-rafiki.png', // Replace with your image URL
         width: 400.0, // Adjust the width as needed
         height: 400.0, // Adjust the height as needed
         fit: BoxFit.contain, // Adjust the fit property as needed
       ),
     ),
    );
  }
}
