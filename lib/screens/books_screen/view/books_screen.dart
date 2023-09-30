import 'package:e_commerce_app/screens/books_screen/view/widget/books_screen_body.dart';
import 'package:e_commerce_app/screens/login/view/widget/Login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class BooksScreen extends StatelessWidget {
  const BooksScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BooksScreenBody();
  }
}