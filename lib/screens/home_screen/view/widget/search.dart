import 'package:e_commerce_app/screens/home_screen/view_model/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../view_model/cubit/cubit.dart';



class SearchView extends StatelessWidget {
 SearchView({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(body: BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        var cubit=HomeCubit.get(context);
        return SafeArea(
          child: Column(
            children: [
              Material(elevation: 10,
                child: CustomTextFormField(icon: InkWell(onTap: (){
                  Navigator.pop(context);
                },
                    child: const Icon(Icons.arrow_back,color:Colors.blueAccent,)),
                    onFieldSubmitted: (value){
                  print(searchController.text);
                      HomeCubit.get(context).searchForBooks(searchController.text);
                 print( HomeCubit.get(context).searchModel?.data?.products?.length);
                    },
                    hintText: 'Search for a books',
                    inputType: TextInputType.text,
                    controller: searchController),
              ),
              SizedBox(height: 14.h,),
              cubit.searchModel == null  ?Expanded(child: Center(child: Image.asset('assets/img/Done-rafiki.png',width: 250.w),)) :
              Expanded(
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 16.w),
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      final product = HomeCubit.get(context).searchModel?.data?.products?[index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: ListTile(
                          tileColor: Colors.grey[200],
                          leading: Image.network(
                            product?.image ?? '',
                            fit: BoxFit.fill,
                          ),
                          subtitle: Text(product?.name ?? ''),
                          title: Text(product?.category ?? ''),
                        ),
                      );
                    },
                    itemCount: HomeCubit.get(context).searchModel?.data?.products?.length,
                  )

                ),
              )
            ],
          ),
        );
      },
    ),);
  }
}
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    required this.hintText,
    required this.inputType,
    required this.controller,
    this.onFieldSubmitted,
    this.validator,
    this.maxLines,
    this.icon,
  }) : super(key: key);
  final String hintText;
  final TextInputType inputType;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final int? maxLines ;
  final void Function(String)? onFieldSubmitted;
  final Widget ?icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(cursorColor:HexColor('#174068'),
      onFieldSubmitted:onFieldSubmitted ,
      maxLines: maxLines,
      keyboardType: inputType,
      controller: controller,
      validator: validator,
      decoration: InputDecoration(prefixIcon: icon,
        hintText: hintText,
        border: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(color: Color(0xff091E4A)),
      borderRadius: BorderRadius.circular(
        4,
      ),
    );
  }
}