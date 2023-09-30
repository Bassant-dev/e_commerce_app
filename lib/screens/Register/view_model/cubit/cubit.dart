import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/screens/Register/view_model/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/dio.dart';
import '../../model/Register_model.dart';




class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());


  final Dio dio = Dio();

  static RegisterCubit get(context) => BlocProvider.of<RegisterCubit>(context);
  RegisterModel? registerModel;
  SingupModel ? singupModel;
  void addRegister({required String name,required String email,required String phone,
   required String password,required String ConfirmPassword}){
    emit(RegisterLoadingState());
    DioHelper.postData(
      url: "/register",
      data: {
        'name':name,
        'email':email,
        'phone':phone,
        'password':password,
        'password_confirmation':ConfirmPassword
      },

    ).then((value) {
      print(value.data['data']['token']);
      CacheHelper.saveData(key:"token", value:value.data['data']['token']);
      print(CacheHelper.getData(key: 'token'));
      emit(RegisterSuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(RegisterErrorState());
    });
  }

  void verify({required String  verify_code}){
    emit(VerifyLoadingState());
    DioHelper.postData(
      url: "/verify-email",
      token: CacheHelper.getData(key: "token"),
        data: {
        "verify_code":verify_code
    }
    ).then((value) {

      emit(VerifySuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(VerifyErrorState());
    });
  }
  void Resendverify(){
    emit(ResetVrifyLoadingState());
    DioHelper.getData(
        url: "/resend-verify-code",
        token: CacheHelper.getData(key: "token"),
    ).then((value) {

      emit(ResetVrifySuccessState());
    }).catchError((errror){
      if(errror is DioException){
        print(errror.response);
      }
      print(errror);
      if(errror is DioError && errror.response?.statusCode==422){
        final e = errror.response?.data;
        final m = e["message"];
        print(e);
        print(m);
      }
      emit(ResetVrifyErrorState());
    });
  }

}