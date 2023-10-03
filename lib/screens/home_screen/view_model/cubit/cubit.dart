import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/screens/home_screen/model/bestseller_model.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/dio.dart';

import '../../../books_screen/view/books_screen.dart';
import '../../../cart_screen/view/cart_screen.dart';
import '../../../fav_screen/view/fav_screen.dart';
import '../../../profile_screen/view/profile_screen.dart';
import '../../model/category model.dart';
import '../../model/newarrival_model.dart';
import '../../model/searchh_model.dart';
import '../../model/slider_model.dart';
import '../../view/home_screen.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  final Dio dio = Dio();

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.book,
      ),
      label: 'Books',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite,
      ),
      label: 'Favourite',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.shopping_cart_outlined,
      ),
      label: 'Cart',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.person,
      ),
      label: 'Person',
    ),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }
  final homeScreen =HomeScreenContent();
  final booksScreen =  BooksScreen();
  final favouriteScreen = FavScreen();
  final cartScreen = CartScreen();
  final profileScreen = ProfileScreen();


  Widget getCurrentScreen() {
    switch (currentIndex) {
      case 0:
        return homeScreen;
      case 1:
        return booksScreen;
      case 2:
        return favouriteScreen;
     case 3:
        return cartScreen;
      default:
        return  profileScreen;
    }
  }
  SliderModel ? sliderModel;
  Future<void>GetSlider()async
  {
    sliderModel=null;
    emit(SliderLoadingState());
    Response data = await DioHelper.getData(
        url: '/sliders',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      sliderModel = SliderModel.fromJson(data.data);
      print(sliderModel!.data!.sliders);
      emit(SliderSuccessState());
    }else{

      emit(SliderErrorState());

    }



  }


  CategoryModel?categoryModel;
  Future<void>GetCategory()async
  {
    sliderModel=null;
    emit(CategoryLoadingState());
    Response data = await DioHelper.getData(
        url: '/categories',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      categoryModel =CategoryModel.fromJson(data.data);
      print(categoryModel!.data!.categories);
      emit(CategorySuccessState());
    }else{
      emit(CategoryErrorState());

    }



  }
  BestSellerModel ? bestSellerModel;
  Future<void>GetBestSeller()async
  {
    bestSellerModel=null;
    emit(CategoryLoadingState());
    Response data = await DioHelper.getData(

        url: '/products-bestseller',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      bestSellerModel =BestSellerModel.fromJson(data.data);
      print(bestSellerModel!.data!.products);
      emit(CategorySuccessState());
    }else{
      emit(CategoryErrorState());

    }



  }
  NewArrivalModel? newArrivalModel;
  Future<void>GetNewArrival()async
  {
    newArrivalModel=null;
    emit(NewArrivalLoadingState());
    Response data = await DioHelper.getData(

        url: '/products-new-arrivals',
        token: await CacheHelper.getData(key: "token"));
    if (data.statusCode == 200) {
      newArrivalModel =NewArrivalModel.fromJson(data.data);
      print(newArrivalModel!.data!.products);
      emit(NewArrivalSuccessState());
    }else{
      emit(NewArrivalErrorState());

    }



  }
  SearchModel? searchModel;

  Future<void> searchForBooks(String name) async {
    emit(SearchLoadingState());


    DioHelper.getData(
      url: '/products-search?name=$name',
      token: CacheHelper.getData(key: "token"),
    ).then((response) {
      searchModel = SearchModel.fromJson(response.data);
      emit(SearchSuccessState());
    }).catchError((e) {
      if (e is DioError && e.response?.statusCode == 401) {
        final error = e.response?.data;
        final m = error["message"];
        print(error);
        print(m);
      }
      emit(SearchFailState());
    });
  }


}