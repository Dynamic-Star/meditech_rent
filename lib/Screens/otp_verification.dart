import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech_rent/Screens/complete_profile.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_cubit.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_state.dart';

class OTPVerify extends StatelessWidget {
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const SizedBox(height: 30),
              const Align(
                  alignment: Alignment.topLeft,
                  child: BoldFont("Phone Verification", 20, darkblue)),
              const SizedBox(height: 10),
              const Align(
                  alignment: Alignment.topLeft,
                  child: PlainFont("We have sent you an SMS with a 6-digit code to\nyour registered mobile number.", 16, black)),
              const Spacer(),
              const Align(
                  alignment: Alignment.topLeft,
                  child: BoldFont("Enter your code below", 16, darkblue)),
              const SizedBox(height: 20),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 6,
                controller: otpController,
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
                  hintText: "Enter OTP received",
                  counterText: "",
                  hintStyle: const TextStyle(color: Colors.grey),
                  contentPadding: const EdgeInsets.all(20),
                ),
              ),
              const Spacer(),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if(state is AuthLoggedInState){
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=> const CompleteProfile()));
                  //NAVIGATION AFTER PHONE VERIFICATION
                  }
                  else if(state is AuthErrorState){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error),
                      backgroundColor: Colors.red,
                        duration: const Duration(milliseconds: 3000),
                      )
                    );
                  }

                },
                builder: (context, state) {
                  if(state is AuthLoadingState){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return MaterialButton(
                    elevation: 0,
                    color: darkblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context).verifyOTP(otpController.text);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: BoldFont("Confirm", 16, white),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PlainFont("Didn't received OTP ?  ", 16, black),
                  GestureDetector(
                    onTap: (){},
                    child: const BoldFont("Resend", 16, darkblue),
                  )
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}