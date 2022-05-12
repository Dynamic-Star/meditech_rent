import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech_rent/Screens/welcome_screen.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:meditech_rent/email_models/user_model.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_cubit.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_state.dart';
import 'package:meditech_rent/google_firebase/authsignout.dart';


class Buyer extends StatefulWidget {
  const Buyer({Key? key}) : super(key: key);

  @override
  State<Buyer> createState() => _BuyerState();
}

class _BuyerState extends State<Buyer> {
  bool _isLogOut = true;
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("email_users")
        .doc(user?.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5FFFD),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffF5FFFD),
        leading: BackButton(onPressed: () {
          Navigator.pop(context);
        }, color: darkblue),
        title: const BoldFont('My Account', 20, darkblue),
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              Image.asset(
                'assets/images/8-modified.png',
                height: 80,
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldFont('${loggedInUser.firstName} ${loggedInUser.secondName}', 19, darkblue),
                  SizedBox(
                    height: 5,
                  ),
                  BoldFont('${loggedInUser.email}', 16, darkblue),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 60,
          ),
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                  color: darkblue,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18),
                      topRight: Radius.circular(18))),
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.topCenter,
                      child:
                      BoldFont('Welcome to your Rental Profile', 20, white),
                    ),
                    const SizedBox(height: 60),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child:
                          const BoldFont("See your Products", 20, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: const BoldFont(
                              "See billing and days left", 20, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white),
                        const SizedBox(width: 10),
                        BlocConsumer<AuthCubit, AuthState>(
                          listener: (context, state) {
                            if(state is AuthLoggedOutState){
                              Navigator.popUntil(context, (route) => route.isFirst);
                              Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context)=>const WelcomeScreen()));
                            }
                          },
                          builder: (context, state) {
                            return GestureDetector(
                                onTap: ()async{
                                  setState(() {
                                    _isLogOut = true;
                                  });
                                  await Authentication.signOut(context: context);
                                  setState(() {
                                    _isLogOut = false;
                                  });
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  WelcomeScreen()));
                                  BlocProvider.of<AuthCubit>(context).logOut();
                                },
                                child: const BoldFont("Log Out", 18, white));
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
