import 'package:e_commerce_app/screens/Register/view/Register_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';

import '../../../../core/components.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class  CartScreenBody extends StatelessWidget {
  CartScreenBody({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocConsumer< CartCubit, CartStates>(
      listener: (context, state) async {

        },

      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Cart', style: TextStyle(color: Colors.white)),
          ),
          body: Scaffold(),
        );
      },
    );
  }
}