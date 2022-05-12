import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditech_rent/centralized.dart';
import 'continue_buyer_seller.dart';
import 'forgot_password.dart';

class EmailLogIn extends StatefulWidget {
  const EmailLogIn({Key? key}) : super(key: key);

  @override
  State<EmailLogIn> createState() => _EmailLogInState();
}

class _EmailLogInState extends State<EmailLogIn> {

  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  //firebase
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    //email form field
    final emailField = TextFormField(
        controller: emailController,
        autofocus: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: white, filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Email ID",
          hintStyle: const TextStyle(
              fontFamily: "Poppins",
              color: hint, fontSize: 16
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: darkblue)
          ),
        ),

        validator: (value) {
          if(value!.isEmpty){
            return ("Please enter your Email");
          }
          //reg expression for email validation
          if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]").hasMatch(value)){
            return ("Please enter a valid Email");
          }
          return null;
        },

        onSaved: (value)
        {
          emailController.text = value!;
        },
        textInputAction: TextInputAction.next
    ); //EMAIL ID

    //password field
    final passwordField = TextFormField(
        controller: passwordController,
        autofocus: false,
        obscureText: true,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          fillColor: white, filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Password",
          hintStyle: const TextStyle(
              fontFamily: "Poppins",
              color: hint, fontSize: 16
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(color: darkblue)
          ),
        ),

        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if(value!.isEmpty){
            return("Please enter your password");
          }
          if(!regex.hasMatch(value)){
            return("Please enter a valid password (min 6 char)");
          }
          return null;
        },

        onSaved: (value)
        {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done
    );//PASSWORD


    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [background, white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter
            )
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 77),
                    Image.asset("assets/images/MediTech-Rent.png", height: 140),
                    const SizedBox(height: 30),
                    const BoldFont("Welcome to", 20, blue),
                    const BoldFont("Meditech-Rent", 20, darkblue),
                    const SizedBox(height: 50),
                    emailField,
                    const SizedBox(height: 20),
                    passwordField,
                    const SizedBox(height: 40),
                    MaterialButton(
                        elevation: 0, color: darkblue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          signIn(emailController.text, passwordController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Spacer(),
                              BoldFont("Log In", 17, white),
                              Spacer(),
                            ],
                          ),
                        )
                    ),//LOG IN BUTTON
                    const SizedBox(height: 20),
                    GestureDetector(
                      child: const BoldFont("Forgot Password ?  Reset", 16, darkblue),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPassword()));
                      },
                    ),//Navigate Register Screen
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Login Function
void signIn(String email, String password) async {
    if(_formkey.currentState!.validate()){
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
        Fluttertoast.showToast(msg: "Login Successful"),
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context)=>const BuyerSeller())),
      }).catchError((e){
        Fluttertoast.showToast(msg: e!.message);
      });
    }
}

}