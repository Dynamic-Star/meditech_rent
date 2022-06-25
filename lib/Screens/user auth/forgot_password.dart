import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditech_rent/Screens/email_password_login.dart';
import 'package:meditech_rent/centralized.dart';

class ForgotPassword extends StatefulWidget {
 const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controller
  final TextEditingController emailController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  void _submit() {
    final isValid = _formkey.currentState?.validate();
    if (!isValid!) {
      return;
    }
    else {
      if(_formkey.currentState!.validate()){
      }
      _auth.sendPasswordResetEmail(email: emailController.text)
          .then((value) => {
            Fluttertoast.showToast(msg: "Password reset link sent successfully to your email"),
          }).catchError((e){
          Fluttertoast.showToast(msg: e!.message);
        });
      }
    _formkey.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [background, white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Align(
                    alignment: Alignment.topLeft,
                    child: BoldFont("Forgot your Password ?", 20, darkblue)),
                const Align(
                    alignment: Alignment.topLeft,
                    child: PlainFont(
                        "Enter your email here to get the password reset link",
                        16,
                        black)),
                const Spacer(),
                const Align(
                    alignment: Alignment.topLeft,
                    child: BoldFont("Enter your email", 16, darkblue)),
                const SizedBox(height: 10),
                TextFormField(
                  controller: emailController,
                  autofocus: false,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please enter your Email");
                    }
                    //reg expression for email validation
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]")
                        .hasMatch(value)) {
                      return ("Please enter a valid Email");
                    }
                    return null;
                  },
                  onSaved: (value) {
                    emailController.text = value!;
                  },
                  decoration: InputDecoration(
                    fillColor: white,
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    hintText: "Email ID",
                    hintStyle: const TextStyle(
                        fontFamily: "Poppins", color: hint, fontSize: 16),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(color: darkblue)),
                  ),
                ),
                const Spacer(),
                MaterialButton(
                    elevation: 0,
                    color: darkblue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    onPressed: () {
                      _auth.sendPasswordResetEmail(email: emailController.text);
                      _submit();
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: const [
                          Spacer(),
                          BoldFont("Send", 17, white),
                          Spacer(),
                        ],
                      ),
                    )),
                const SizedBox(height: 20),
                MaterialButton(
                    elevation: 0, color: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: darkblue)
                    ),
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context)=>const EmailLogIn()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: const [
                          Spacer(),
                          BoldFont("Back to Log In", 16, darkblue),
                          Spacer(),
                        ],
                      ),
                    )
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PlainFont("Didn't Received mail ? ", 16, black),
                    GestureDetector(
                      child: const BoldFont(" Resend Link", 16, darkblue),
                      onTap: () {
                        resendLink();
                      },
                    ),
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // resend password reset link
  void resendLink() async {
    if(_formkey.currentState!.validate()){
      await _auth.sendPasswordResetEmail(email: emailController.text)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Link Resent Successfully"),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }
}
