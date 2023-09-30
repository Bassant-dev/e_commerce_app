import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class BooksCubit extends Cubit<BooksStates> {
  BooksCubit() : super(BooksInitialState());


  final Dio dio = Dio();

  static BooksCubit get(context) => BlocProvider.of<BooksCubit>(context);





}