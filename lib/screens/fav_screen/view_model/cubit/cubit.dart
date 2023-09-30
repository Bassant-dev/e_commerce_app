import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/fav_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitialState());


  final Dio dio = Dio();

  static FavCubit get(context) => BlocProvider.of<FavCubit>(context);





}