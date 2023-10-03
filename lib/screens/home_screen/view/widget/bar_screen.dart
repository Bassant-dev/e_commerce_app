import 'package:e_commerce_app/screens/home_screen/view/widget/search.dart';
import 'package:e_commerce_app/screens/home_screen/view_model/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';


import '../../view_model/cubit/cubit.dart';

class start extends StatelessWidget {
  static String id = 'start';

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: HexColor("#174068"),
            title: const Text(
              'Books App',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search,color: Colors.white,),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  SearchView(),
                    ),
                  );

                },
              ),
            ],
          ),

          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNavBar(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.getCurrentScreen(), // Use getCurrentScreen() from StoreCubit
        );
      },
    );
  }
}