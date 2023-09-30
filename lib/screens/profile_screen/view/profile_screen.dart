import 'package:e_commerce_app/screens/books_screen/view/widget/books_screen_body.dart';
import 'package:e_commerce_app/screens/login/view/widget/Login_screen.dart';
import 'package:e_commerce_app/screens/profile_screen/view/widget/profile_screen_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  ProfileScreenBody();
  }
}