import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache_helper.dart';
import '../../model/Login_model.dart';



class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());


  final Dio dio = Dio();

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  LoginModel? loginModel;


  void login(BuildContext context, String email, String password) async {
    emit(LoginLoadingState());

    DioHelper.postData(
      url: "/login",
      token: CacheHelper.getData(key: "token"),
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      print(value.data['data']['token']);
      print(value);
      CacheHelper.saveData(key: 'token', value: value.data['data']['token']);
      print("bassant");
      print(CacheHelper.getData(key: "token"));
      print("bassant");
      emit(LoginSuccessState(''));
    }).catchError((error) {
      print(error.toString());
      if (error is DioError) {
        emit(LoginErrorState());
      }
    });
  }



}