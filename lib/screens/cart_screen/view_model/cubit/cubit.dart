import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/cart_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class CartCubit extends Cubit<CartStates> {
  CartCubit() : super(CartInitialState());


  final Dio dio = Dio();

  static CartCubit get(context) => BlocProvider.of<CartCubit>(context);





}