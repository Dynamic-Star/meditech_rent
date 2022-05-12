import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_cubit.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_state.dart';
import 'otp_verification.dart';

class PhoneLogIn extends StatefulWidget {

  PhoneLogIn({Key? key}) : super(key: key);

  @override
  State<PhoneLogIn> createState() => _PhoneLogInState();
}

class _PhoneLogInState extends State<PhoneLogIn> {
  TextEditingController phoneController = TextEditingController();
  final _formkey = GlobalKey<FormState>();


  void _submit() {
    final isValid = _formkey.currentState?.validate();
    if (!isValid!) {
      return;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [background, white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Form(
            key: _formkey,
            child: Column(
                children: [
                  const SizedBox(height: 100),
                  Image.asset("assets/images/MediTech-Rent.png",height: 140),
                  const SizedBox(height: 30),
                  const BoldFont("Welcome to", 20, blue),
                  const BoldFont("Meditech-Rent", 20, darkblue),
                  const SizedBox(height: 40),
                  const Align(
                      alignment: Alignment.topLeft,
                      child: PlainFont("Enter your mobile number with country code\ne.g. +60947221**** (maintain no gap)", 16, black)),
                  const SizedBox(height: 20),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    controller: phoneController,
                    validator: (value){
                      if(value!.isEmpty){
                        return ("Please Enter your Phone Number");
                      }
                      if(!RegExp(r'^.{10,}$').hasMatch(value)){
                        return ("Invalid number (10 digits required)");
                      }
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(
                          color: blue,
                          width: 1.0,
                        ),
                      ),
                      hintText: "Mobile Number",
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(20),
                    ),
                  ),
                  const Spacer(),
                  BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if(state is AuthCodeSentState){
                        Navigator.push(context, CupertinoPageRoute(builder: (context) => OTPVerify()));
                        //PAGE ROUTING AFTER ENTER PHONE NO.
                      }
                    },
                    builder: (context, state) {
                      if(state is AuthLoadingState){
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }

                      return MaterialButton(
                          elevation: 0, color: darkblue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                          ),
                          onPressed: () {
                            _submit();
                            String phoneNumber =   //COUNTRY CODE OF USER -- CHANGE FOR DIFFERENT COUNTRY
                                phoneController.text;
                            BlocProvider.of<AuthCubit>(context).sendOTP(phoneNumber);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(11.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                BoldFont("Send OTP", 16, white),
                              ],
                            ),
                          )
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
          ),
          ),
        ),
    );
  }
}
