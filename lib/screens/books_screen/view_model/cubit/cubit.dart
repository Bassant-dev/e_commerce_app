import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../cart_screen/model/add_tocart_model.dart';
import '../../../fav_screen/model/add_fav_model.dart';
import '../../model/books_details_model.dart';
import '../../model/get_books_model.dart';





class BooksCubit extends Cubit<BooksStates> {
  BooksCubit() : super(BooksInitialState());


  final Dio dio = Dio();

  static BooksCubit get(context) => BlocProvider.of<BooksCubit>(context);

  BooksDetailsModel? booksDetailsModel;
  Future<void> GetBooksDetails(int id) async {
    booksDetailsModel = null;
    emit(GetBooksDetailsLoadingState());

    try {
      Response data = await DioHelper.getData(
        url: '/products/$id', // Remove curly braces from the URL
        token: await CacheHelper.getData(key: "token"),
      );

      if (data.statusCode == 200) {
        booksDetailsModel = BooksDetailsModel.fromJson(data.data);
        print(booksDetailsModel!.data!);
        emit(GetBooksDetailsSuccessState());
        print("successsssss");
      } else {
        print("errrorrrr");
        emit(GetBooksDetailsFailState());
      }
    } catch (error) {
      print(error.toString());
      if(error is DioError && error.response?.statusCode==404){
        final e = error.response?.data;
        final m = e["message"];
        print(error);
        print(m);
      }
      emit(GetBooksDetailsFailState());
    }
  }


  GetBooksModel ? getBooksModel;
  Future<void>GetBooks()async
  {
    getBooksModel=null;
    emit( GetBooksLoadingState());
    Response data = await DioHelper.getData(
        url: '/products',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      getBooksModel =  GetBooksModel.fromJson(data.data);

      emit(GetBooksSuccessState());
      print("successsssss");
    }else{
      print("errrorrrr");
      emit( GetBooksFailState());

    }



  }
  AddToCartModel ? addToCartModel;
  void addToCart({required String product_id}){
    emit(AddToCartLoadingState());
    DioHelper.postData(
        url: "/add-to-cart",
        data: {
          'product_id':product_id,
        },
        token: CacheHelper.getData(key:"token")

    ).then((value) {
      print(value.data['data']['token']);

      print(CacheHelper.getData(key: 'token'));
      emit(AddToCartSuccessState());


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
      emit(AddToCartFailState());
    });
  }

  AddToFavModel ? addToFavModel;
  void addToFav({required String product_id}){
    emit(AddToFavLoadingState());
    DioHelper.postData(
        url: "/add-to-wishlist",
        data: {
          'product_id':product_id,
        },
        token: CacheHelper.getData(key:"token")

    ).then((value) {
      print(value.data['data']['token']);
      print("mostafa add to fav");
      print(CacheHelper.getData(key: 'token'));
      emit(AddToFavSuccessState());

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
      emit(AddToFavFailState());
    });
  }

}