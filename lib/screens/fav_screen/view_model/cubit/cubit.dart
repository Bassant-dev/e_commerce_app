import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/core/dio.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/fav_screen/model/show_fav_model.dart';
import 'package:e_commerce_app/screens/fav_screen/view_model/cubit/states.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../books_screen/model/books_details_model.dart';
import '../../model/add_fav_model.dart';
import '../../model/delete_fav_model.dart';




class FavCubit extends Cubit<FavStates> {
  FavCubit() : super(FavInitialState());


  final Dio dio = Dio();

  static FavCubit get(context) => BlocProvider.of<FavCubit>(context);

  List< DataModel> favoriteProductIds = [];

  void delete(  DataModel productd) {
    favoriteProductIds.remove(productd);
    emit(RemovedSuccessfully());
  }

  bool isProductFavorite(  DataModel productId) {
    productId.fav=!productId.fav;
    if(!productId.fav && favoriteProductIds.contains(productId)){
      favoriteProductIds.remove(productId);
    }
    if(productId.fav){
      favoriteProductIds.add(productId);
    }
    emit(FavoritesState(favoriteProductIds));
    return productId.fav;

  }
  // AddToFavModel ? addToFavModel;
  // void addToFav({required String product_id}){
  //   emit(AddToFavLoadingState());
  //   DioHelper.postData(
  //       url: "/add-to-wishlist",
  //       data: {
  //         'product_id':product_id,
  //       },
  //       token: CacheHelper.getData(key:"token")
  //
  //   ).then((value) {
  //     print(value.data['data']['token']);
  //
  //     print(CacheHelper.getData(key: 'token'));
  //     emit(AddToFavSuccessState());
  //
  //   }).catchError((errror){
  //     if(errror is DioException){
  //       print(errror.response);
  //     }
  //     print(errror);
  //     if(errror is DioError && errror.response?.statusCode==422){
  //       final e = errror.response?.data;
  //       final m = e["message"];
  //       print(e);
  //       print(m);
  //     }
  //     emit(AddToFavFailState());
  //   });
  // }
  ShowFavModel ?showFavModel;
  List<int> favIds = [];
  Future<void>ShowFav()async
  {
    favIds = [];
    showFavModel=null;
    emit( ShowFavLoadingState());
    Response data = await DioHelper.getData(
        url: '/wishlist',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      showFavModel=  ShowFavModel.fromJson(data.data);
      //print( showFavModel!.data!.currentPage);
      for (var item in showFavModel!.data!.data!) {
        favIds.add(item.id!.toInt());
      }
      emit(ShowFavSuccessState());
      print("successsssss");
      print(favIds);

    }else{
      print("errrorrrr");
      emit( ShowFavFailState());

    }



  }
  DeleteFavModel? deleteFavModel;
  void DeleteFav({required String product_id}){
    emit(RemoveFavLoadingState());
    DioHelper.postData(
        url: "/remove-from-wishlist",
        data: {
          'product_id':product_id,
        },
        token: CacheHelper.getData(key:"token")

    ).then((value) {
      print(value.data['data']['token']);

      print(CacheHelper.getData(key: 'token'));
      emit(RemoveFavSuccessState());

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
      emit(RemoveFavFailState());
    });
  }


}