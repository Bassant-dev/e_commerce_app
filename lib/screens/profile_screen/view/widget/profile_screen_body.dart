import 'package:e_commerce_app/screens/Register/view/widget/otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../core/cache_helper.dart';
import '../../../../core/components.dart';
import '../../../books_screen/model/books_details_model.dart';
import '../../../home_screen/view/home_screen.dart';
import '../../../login/view/login_screen_body.dart';
import '../../view_model/cubit/cubit.dart';
import '../../view_model/cubit/states.dart';

class ProfileScreenBody extends StatefulWidget {
  ProfileScreenBody({Key? key}) : super(key: key);

  @override
  State<ProfileScreenBody> createState() => _ProfileScreenBodyState();
}

class _ProfileScreenBodyState extends State<ProfileScreenBody> {
  bool isvisible = false;

  var emailController = TextEditingController();

  var nameController = TextEditingController();

  var phoneController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final cubit = ProfileCubit.get(context);
        final profileData = cubit.showProfileModel?.data;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor("#174068"),
            title: Text(
              'Profile',
              style: TextStyle(color: Colors.white),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.blue),
                      title: Text('Name: ${profileData?.name ?? ''}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.phone, color: Colors.green),
                      title: Text('Phone: ${profileData?.phone ?? ''}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email, color: Colors.red),
                      title: Text('Email: ${profileData?.email ?? ''}'),
                    ),
                    ListTile(
                      leading: Icon(Icons.location_city, color: Colors.orange),
                      title: Text('City: ${profileData?.city ?? ''}'),
                    ),
                    SizedBox(height: 16.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'If You Want To Edit Profile : ',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(height: 16.h),
                    defaultFormField(
                      prifex: Icons.person,
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
                      prifex: Icons.phone,
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
                    Card(
                      child: ExpansionTile(
                        title: Text("GOVERNMENT"),
                        children: [
                          StatefulBuilder(
                            builder: (BuildContext context, StateSetter setState /*You can rename this!*/) {
                              return Container(
                                height: 200,
                                child: ListView.builder(
                                  itemCount: cubit.getGovernmentModel != null ? cubit.getGovernmentModel!.data!.length : 0,
                                  itemBuilder: (context, index) {
                                    final Data = cubit.getGovernmentModel?.data?[index];
                                    return RadioListTile(
                                      title: Text("${Data!.governorateNameEn}"),
                                      value: index + 1,
                                      groupValue: cubit.selectItem,
                                      onChanged: (value) {
                                        print(value);
                                        print("m + b");
                                        setState(() {
                                       print(Data.governorateNameEn);
                                          ProfileCubit.get(context).selectItem = value;
                                          print(value.toString());
                                        });
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          isvisible = true;
                          ProfileCubit.get(context).updateProfile(name: nameController.text,

                              phone: phoneController.text,city:'${ProfileCubit.get(context).selectItem}' );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: HexColor('#174068'),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        minimumSize: Size(312.w, 48.h),
                      ),
                      child: state is ProfileEditLoadingState
                          ? CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Text(
                        'Update Profile',
                        style: GoogleFonts.roboto(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                      ),
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
