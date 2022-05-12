import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:meditech_rent/email_models/user_model.dart';
import 'continue_buyer_seller.dart';
import 'email_password_login.dart';

class EmailRegister extends StatefulWidget {
  const EmailRegister({Key? key}) : super(key: key);

  @override
  State<EmailRegister> createState() => _EmailRegisterState();
}

class _EmailRegisterState extends State<EmailRegister> {

  final _auth = FirebaseAuth.instance;

  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController secondNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //first name field
    final firstName = TextFormField(
        controller: firstNameController,
        autofocus: false,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: white, filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "First name",
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
          RegExp regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            return("First name can't be empty");
          }
          if(!regex.hasMatch(value)){
            return("Please enter a valid Name (min 3 char)");
          }
          return null;
        },
        onSaved: (value)
        {
          firstNameController.text = value!;
        },
        textInputAction: TextInputAction.next
    ); //FIRST NAME

    //second name field
    final secondName = TextFormField(
        controller: secondNameController,
        autofocus: false,
        keyboardType: TextInputType.name,
        decoration: InputDecoration(
          fillColor: white, filled: true,
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Last Name",
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
          RegExp regex = RegExp(r'^.{3,}$');
          if(value!.isEmpty){
            return("Second name can't be empty");
          }
        },
        onSaved: (value)
        {
          secondNameController.text = value!;
        },
        textInputAction: TextInputAction.next
    ); //SECOND NAME

    //email field
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
        obscureText: true,
        autofocus: false,
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    Image.asset("assets/images/MediTech-Rent.png", height: 140),
                    const SizedBox(height: 30),
                    const BoldFont("Welcome to", 20, blue),
                    const BoldFont("Meditech-Rent", 20, darkblue),
                    const SizedBox(height: 25),
                    firstName,
                    const SizedBox(height: 25),
                    secondName,
                    const SizedBox(height: 25),
                    emailField,
                    const SizedBox(height: 25),
                    passwordField,
                    const SizedBox(height: 40),
                    MaterialButton(
                        elevation: 0, color: darkblue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () {
                          signUp(emailController.text, passwordController.text);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: const [
                              Spacer(),
                              BoldFont("Register", 17, white),
                              Spacer(),
                            ],
                          ),
                        )
                    ),//REGISTER BUTTON
                    const SizedBox(height: 30),
                    GestureDetector(
                      child: const BoldFont("Already a user ?  Log In", 16, darkblue),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailLogIn()));
                      },
                    ),//Navigate Log In Screen
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //Sign Up Function
  void signUp(String email, String password) async {
    if(_formkey.currentState!.validate()){

      await _auth.createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {
            postDetailsToFirestore()
      }).catchError((e)
      {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  //post details to firebase
postDetailsToFirestore() async{

  // calling our fire store
  //calling user model
  //sending these values

  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  User? user = _auth.currentUser;

  UserModel userModel = UserModel();

  //writing all the values
  userModel.email = user!.email;
  userModel.uid = user.uid;
  userModel.firstName = firstNameController.text;
  userModel.secondName = secondNameController.text;
  
  await firebaseFirestore
  .collection("email_users")
  .doc(user.uid)
  .set(userModel.toMap());
  Fluttertoast.showToast(msg: "Account Created Successfully");
  
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
      builder: (context)=>const BuyerSeller()), (route) => false);
}

}