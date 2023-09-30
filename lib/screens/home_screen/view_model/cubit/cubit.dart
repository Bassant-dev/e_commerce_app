import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:e_commerce_app/screens/home_screen/model/bestseller_model.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/states.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/cache_helper.dart';
import '../../../../core/dio.dart';
import '../../model/category model.dart';
import '../../model/newarrival_model.dart';
import '../../model/slider_model.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of<HomeCubit>(context);

  final Dio dio = Dio();


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
}