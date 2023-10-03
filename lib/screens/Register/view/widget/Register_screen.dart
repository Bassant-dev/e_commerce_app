import 'package:e_commerce_app/screens/Register/view/widget/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/components.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../../home_screen/view/widget/bar_screen.dart';
import '../../../login/view/login_screen_body.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class RegisterScreenBody extends StatefulWidget {
  RegisterScreenBody({Key? key}) : super(key: key);

  @override
  _RegisterScreenBodyState createState() => _RegisterScreenBodyState();
}

class _RegisterScreenBodyState extends State<RegisterScreenBody> {
  bool isvisible = false;
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var nameController = TextEditingController();
  var confirmPasswordController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Future<void> storeTokenInSharedPreferences(String token) async {
    CacheHelper.saveData(key: "token", value: token);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubit, RegisterStates>(
      listener: (BuildContext context, RegisterStates state) {
         if(state is RegisterSuccessState){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>  start (),
            ),
          );
        }

      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text('Register',style: TextStyle(color: Colors.white),),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/img/reg_book.jpg', // Replace with your image path
                      height: 140.h,

                    ),
                    SizedBox(height: 16.h),
                    defaultFormField(
                      prifex:Icons.person,
                      controller: nameController,
                      type: TextInputType.emailAddress,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name';
                        } else if (nameController.text.length < 3) {
                          return 'Name must be more than 3 characters';
                        }
                        return null;
                      },
                      label: 'Name',
                    ),
                    SizedBox(height: 16.h),
                    defaultFormField(
                      controller: emailController,
                      type: TextInputType.emailAddress,
                      prifex:Icons.email,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      label: 'Email',
                    ),
                    SizedBox(height: 16.h),
                    defaultFormField(
                      prifex:Icons.phone,
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your phone';
                        } else if (value.length < 11) {
                          return 'Please enter a valid phone number';
                        }
                        return null;
                      },
                      label: 'Phone',
                    ),
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 16.h),
                    defaultFormField(
                      prifex:Icons.lock,
                      controller: confirmPasswordController,
                      type: TextInputType.visiblePassword,
                      validate: (String? value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password again';
                        } else if (passwordController.text != confirmPasswordController.text) {
                          return 'Confirm password doesn\'t match password';
                        }
                        return null;
                      },
                      label: 'Confirm Password',
                    ),
                    SizedBox(height: 16.h),
                    // ... Other form fields ...

                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          isvisible = true;
                          RegisterCubit.get(context).addRegister(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            password: passwordController.text,
                            ConfirmPassword: confirmPasswordController.text,
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
                      child: state is RegisterLoadingState
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Register',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Already have an account? ', style: TextStyle(fontSize: 16.sp)),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const LoginScreen(),
                                    ),
                                  );
                          },
                          child: Text(
                            'Login here',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: HexColor('#174068'),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
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
