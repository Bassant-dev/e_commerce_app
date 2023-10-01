import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/profile_screen/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../model/get_government_model.dart';
import '../../model/show_details_profile.dart';
import '../../model/update_profile_model.dart';




class ProfileCubit extends Cubit<ProfileStates> {
  ProfileCubit() : super(ProfileInitialState());


  final Dio dio = Dio();

  static ProfileCubit get(context) => BlocProvider.of<ProfileCubit>(context);
  GetGovernmentModel? getGovernmentModel;
  Future<void>GetGovernment()async
  {
    emit(GovernmentLoadingState());


    try {
      Response data = await DioHelper.getData(
          url: '/governorates',
          token: CacheHelper.getData(key: "token"));
      if (data.statusCode == 200) {
        getGovernmentModel =  GetGovernmentModel.fromJson(data.data);
      }

      emit(GovernmentSuccessState());
    } on Exception catch (e) {
      if (e is DioError && e.response?.statusCode == 401) {
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(GovernmentFailState());
      print(e.toString());
    }
  }
  UpdateProfileModel? updateProfileModel;
  void updateProfile({required String name,required String phone,required String city}){
    emit(ProfileEditLoadingState());
    DioHelper.postData(
      url: "/update-profile",
      data: {
        'name':name,
        'phone':phone,
        'city':city
      },
      token: CacheHelper.getData(key: "token"),
    ).then((value) {
      print(value);
      emit(ProfileEditSuccessState ());

    }).catchError((errror){
      if(errror is DioError && errror.response?.statusCode==401){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(ProfileEditFailState());
    });
  }
  ShowProfileModel ? showProfileModel;

  Future<void> GetProfile() async {
    try {

      emit(ProfileLoadingState());

      Response data = await DioHelper.getData(
        url: '/profile',
        token: await CacheHelper.getData(key: "token"),
      );

      if (data.statusCode == 200) {
        showProfileModel = ShowProfileModel.fromJson(data.data);
        print(showProfileModel!.data!);
        emit(ProfileSuccessState());
      } else {
        emit(ProfileFailState());
      }
    } catch (e) {
      print(CacheHelper.getData(key: "token"));
      print("Error in GetProfile: $e");
      if(e is DioError && e.response?.statusCode==401){
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(ProfileFailState());
    }
  }

  int? selectItem;

  void selectOption(int option) {
    selectItem = option;
    emit(RadioCubitSelectedadd());
  }

}