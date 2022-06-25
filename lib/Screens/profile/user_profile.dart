import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech_rent/Screens/edit_remove_product.dart';
import 'package:meditech_rent/Screens/welcome_screen.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:meditech_rent/email_models/user_model.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_cubit.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_state.dart';
import 'package:meditech_rent/google_firebase/authsignout.dart';
import 'complete_profile.dart';


class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isLogOut = true;
  final uid = FirebaseAuth.instance.currentUser!.uid;
  // UserData loggedInUser = UserData();

  UserData info=UserData(id: "name", userphoto: "p", name: "name", phoneNumber:"34", email: "email", address: "jekS")  ;
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("userInfo")
        .doc(uid)
        .get()
        .then((value) {
      UserData hello = UserData.fromJson(value.data()!);
      setState(() {
        info = hello;
      });
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: white,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              const Padding(padding: EdgeInsets.all(10)),
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                  color: hint,
                  boxShadow: const [BoxShadow(color: blue, spreadRadius: 1, blurRadius: 1)],
                    borderRadius: BorderRadius.circular(100),
                    image:
                    DecorationImage(image: NetworkImage(info.userphoto), fit: BoxFit.fill)),
              ),
              const SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BoldFont(info.name, 18, darkblue),
                  BoldFont(info.email, 16, darkblue),

                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(color: hint),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: [
                Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: BoldFont("Phone number", 16, black)),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: BoldFont(info.phoneNumber, 16, darkblue),
                    )
                  ],
                ),
                const SizedBox(height: 10),
                Column(
                  children: [
                    const Align(
                        alignment: Alignment.topLeft,
                        child: BoldFont("Address", 16, black)),
                    const SizedBox(
                      width: 10,
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: BoldFont(info.address, 16, darkblue),
                    )
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
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
                      BoldFont('Welcome to your meditech Profile', 18, white),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white, size: 21),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const CompleteProfile()));
                          },
                          child:
                          const BoldFont("Edit your profile", 17, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white, size: 21),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const EditRemoveProduct()));
                          },
                          child: const BoldFont(
                              "View your products", 17, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white, size: 21),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: const BoldFont(
                              "Billing and rents", 17, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white, size: 21),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {},
                          child: const BoldFont(
                              "Report an issue", 17, white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.arrow_forward, color: white, size: 21),
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
                                  Navigator.push(context, MaterialPageRoute(builder: (context) =>  const WelcomeScreen()));
                                  BlocProvider.of<AuthCubit>(context).logOut();
                                },
                                child: const BoldFont("Log Out", 17, white));
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

  name() async{
    final auth = FirebaseAuth.instance;
    final useruid= auth.currentUser!.uid;
    final docUser = await FirebaseFirestore.instance.collection("userInfo").doc(useruid).get();
    return
      const BoldFont('Full name', 18, darkblue);
  }
}