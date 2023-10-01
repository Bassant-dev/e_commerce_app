import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../model/books_details_model.dart';
import '../../model/get_books_model.dart';
import '../../model/search_model.dart';




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
  SearchModel? searchModel;
  List<SearchModel>searchResults=[];
  Future<void> searchForDoctor(String name)async
  {
    emit(SearchLoadingState());
    searchResults=[];
    try {
      Response response= await DioHelper.getData(
          url: '/products-search?name=${name}',
          token: CacheHelper.getData(key: "token"));
      print(response.data['message']);
      response.data['data'].forEach((item){
        searchResults.add(SearchModel.fromJson(item));
      });
      emit(SearchSuccessState());
    } on Exception catch (e) {
      if(e is DioError && e.response?.statusCode==404){
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(SearchFailState());
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
      print( getBooksModel!.data!.products);
      emit(GetBooksSuccessState());
      print("successsssss");
    }else{
      print("errrorrrr");
      emit( GetBooksFailState());

    }



  }


}