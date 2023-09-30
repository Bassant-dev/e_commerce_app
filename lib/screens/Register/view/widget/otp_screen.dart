// import 'package:e_commerce_app/screens/Register/view_model/cubit/cubit.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../view_model/cubit/states.dart';
//
// class OtpScreen extends StatelessWidget {
//   final List<TextEditingController> otpControllers = List.generate(6, (_) => TextEditingController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('OTP Verification'),
//       ),
//       body: BlocConsumer<RegisterCubit, RegisterStates>(
//         listener: (context,state){},
//         builder: (context,state){
//           return Center(
//             child: Padding(
//               padding: EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center, // Center vertically
//                 children: [
//                   Text(
//                     'Enter the verification code',
//                     style: TextStyle(fontSize: 18.0),
//                   ),
//                   SizedBox(height: 16.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: List.generate(6, (index) => buildOtpTextField(index)),
//                   ),
//                   SizedBox(height: 16.0),
//                   ElevatedButton(
//                     onPressed: () {
//                       String otp = otpControllers.map((controller) => controller.text).join();
//                       print('Entered OTP: $otp');
//                       RegisterCubit.get(context).verify(verify_code: otp);
//                     },
//                     child: Text('Verify'),
//                   ),
//                   SizedBox(height: 16.0),
//                   TextButton(
//                     onPressed: () {
//                       RegisterCubit.get(context).Resendverify();
//                     },
//                     child: Text('Resend OTP'),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//
//       ),
//     );
//   }
//
//   Widget buildOtpTextField(int index) {
//     return Container(
//       width: 60.0,
//       height: 60.0,
//       child: TextField(
//         controller: otpControllers[index],
//         keyboardType: TextInputType.number,
//         maxLength: 1,
//         style: TextStyle(fontSize: 24.0),
//         textAlign: TextAlign.center,
//         decoration: InputDecoration(
//           counterText: '',
//           enabledBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.grey),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.blue),
//           ),
//         ),
//       ),
//     );
//   }
// }
