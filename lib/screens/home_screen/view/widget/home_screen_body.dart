import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

class HomeScreenBody extends StatelessWidget {
  HomeScreenBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Scaffold(

      body: BlocConsumer<HomeCubit,HomeStates>(builder: (context,state){
        var cubit=HomeCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              ConditionalBuilder(condition: cubit.sliderModel!=null && state is! SliderLoadingState,
                  builder: (context)=>ConditionalBuilder(

                  condition: cubit.sliderModel!.data!.sliders!.isNotEmpty,
                  builder: (context)=>Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      height: 150,
                      color: Colors.red,
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: 130.0,

                          autoPlay: true,
                          autoPlayInterval: Duration(seconds: 2),
                          enlargeCenterPage: true,
                        ),
                        items: cubit.sliderModel!.data!.sliders!.map((slider) {

                          return Container(
                            height: 150,
                            // color: Colors.green,
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                            ),
                            child: Image.network(
                              slider.image ?? 'https://img.freepik.com/free-photo/front-view-smiley-woman-with-fireworks_52683-98180.jpg',
                              fit: BoxFit.cover,
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  fallback: (context)=>Text("empty")),
                  fallback: (context)=>CircularProgressIndicator()),
              SizedBox(height: 30),

            ],
          ),
        );
      },
          listener: (context,state){}),
    );
  }
}
