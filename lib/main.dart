import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:e_commerce_app/screens/Register/view/widget/otp_screen.dart';

import 'package:e_commerce_app/screens/Register/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/books_screen/view/widget/books_details.dart';
import 'package:e_commerce_app/screens/books_screen/view/widget/books_screen_body.dart';
import 'package:e_commerce_app/screens/books_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/cart_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/fav_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/home_screen/view/home_screen.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/login/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/profile_screen/view_model/cubit/cubit.dart';
import 'package:e_commerce_app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import 'core/bloc_observer.dart';
import 'core/cache_helper.dart';
import 'core/dio.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.Init_dio();
  await CacheHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context)=> RegisterCubit()),
        BlocProvider(create: (context)=> LoginCubit()),
        BlocProvider(create: (context)=>  BooksCubit()..GetBooks()),
        BlocProvider(create: (context)=>   FavCubit()..ShowFav()),
        BlocProvider(create: (context)=>   CartCubit()..ShowCart()),
        BlocProvider(create: (context)=>   ProfileCubit()..GetProfile()..GetGovernment()),



        BlocProvider(create: (context)=> HomeCubit()..GetSlider()..GetCategory()..GetBestSeller()..GetNewArrival()),
      ],
      child: ScreenUtilInit(

        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            bottomNavigationBarTheme:  BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: HexColor("#174068"),
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
            ),
            colorScheme: ColorScheme.fromSeed(seedColor: HexColor("#174068")),
            useMaterial3: true,
          ),
          home:  MyHomePage(),
        ),
      ),
    );
  }
}


