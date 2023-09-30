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

class LoginScreenBody extends StatelessWidget {
  LoginScreenBody({Key? key}) : super(key: key);

  bool isvisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  Future<void> storeTokenInSharedPreferences(String token) async {
    CacheHelper.saveData(key: "token", value: token);
  }

  @override
  Widget build(BuildContext context) {
    print(CacheHelper.getData(key: "token"));
    return BlocConsumer<LoginCubit, LoginStates>(
      listener: (context, state) async {
        if (state is LoginSuccessState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Login', style: TextStyle(color: Colors.white)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 24.w), // Changed horizontal padding
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center, // Centered form fields
                  children: [
                    SizedBox(height: 30.h), // Increased the spacing
                    Image.asset(
                      'assets/img/reg_book.jpg',
                      height: 140.h,
                    ),
                    SizedBox(height: 20.h),
                    defaultFormField(
                      controller: emailController,
                      prifex:Icons.email,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                      label: 'Email',
                    ),
                    SizedBox(height: 20.h),
                    defaultFormField(
                      controller: passwordController,
                      prifex:Icons.lock,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      label: 'Password',
                    ),
                    SizedBox(height: 20.h),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          isvisible = true;
                          LoginCubit.get(context).login(
                            context,
                            emailController.text,
                            passwordController.text,
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#174068'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(312.w, 48.h),
                      ),
                      child: state is LoginLoadingState
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Login',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\t have an account? ', style: TextStyle(fontSize: 16.sp)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterScreen(),
                              ),
                            );
                          },
                          child: Text(
                            'Register Now',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: HexColor('#174068'),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),// Added spacing after the button
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
