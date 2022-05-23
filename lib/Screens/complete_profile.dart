import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditech_rent/Screens/home_screen.dart';
import 'package:meditech_rent/Screens/user_profile.dart';
import 'package:meditech_rent/centralized.dart';

class CompleteProfile extends StatefulWidget {
  const CompleteProfile({Key? key}) : super(key: key);

  @override
  State<CompleteProfile> createState() => _CompleteProfileState();
}

class _CompleteProfileState extends State<CompleteProfile> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController address = TextEditingController();


  String photoUrl = "";

  File? imageFile;
  String? imageurl;

  Future PickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemorary = File(image.path);
      setState(() {
        imageFile = imageTemorary;
      });
      uploadphoto(imageFile!);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }


  Future<void> uploadphoto(File image) async {
    final firebaseStorage = FirebaseStorage.instance;
    final userPhoto = FirebaseAuth.instance.currentUser!.uid;

    if (image == null) return;

    if (image != null) {

      var snapshot = await firebaseStorage
          .ref("userPhoto")
          .child(userPhoto)


          .putFile(image);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      log(downloadUrl);
      setState(() {
        photoUrl = downloadUrl;
        imageurl = downloadUrl;
      });
    }
  }

  //form key
  final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 40, 15, 15),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const BoldFont("Complete your profile of", 20, blue),
                    const SizedBox(
                      height: 7,
                    ),
                    const BoldFont("Meditech-Rent", 20, darkblue),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            PickImage();
                          },
                          child: Container(
                            height: 65,
                            width: 65,
                            decoration: BoxDecoration(
                              color: hint,
                              boxShadow: const [BoxShadow(color: blue, spreadRadius: 1, blurRadius: 1)],
                            ),
                            child: imageFile == null?
                            Image.asset("assets/images/Group 41.png"):Image.network(photoUrl,fit: BoxFit.fill,)

                          ),
                          ),
                        const SizedBox(
                          width: 20,
                        ),
                        const BoldFont("Pick your profile picture\nfrom gallery", 18, Colors.black45),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      color: hint,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: PlainFont("Enter full name", 18, black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: name,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        hintText: "Full Name",
                        hintStyle:
                        TextStyle(color: hint, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: blue,
                              width: 2.0,
                            )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if(value!.isEmpty){
                          return("Full name can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid Name (min 3 char)");
                        }
                        return null;
                      },
                    ),//FULL NAME
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: PlainFont("Enter your phone number", 18, black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phone,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        hintText: "Phone Number",
                        hintStyle:
                        TextStyle(color: hint, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: blue,
                              width: 2.0,
                            )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{8,}$');
                        if(value!.isEmpty){
                          return("Phone number can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid number");
                        }
                        return null;
                      },
                    ),//NUMBER
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: PlainFont("Enter your email", 18, black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: email,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        hintText: "Email",
                        hintStyle:
                        TextStyle(color: hint, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: blue,
                              width: 2.0,
                            )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        if(value!.isEmpty){
                          return ("Please enter your Email");
                        }
                        //reg expression for email validation
                        if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+[a-z]").hasMatch(value)){
                          return ("Enter a valid Email");
                        }
                        return null;
                      },
                    ),//EMAIL
                    const SizedBox(
                      height: 20,
                    ),
                    const Align(
                      alignment: Alignment.bottomLeft,
                      child: PlainFont("Enter your address", 18, black),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: address,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        hintText: "Address",
                        hintStyle:
                        TextStyle(color: hint, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            borderSide: BorderSide(
                              color: blue,
                              width: 2.0,
                            )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{5,}$');
                        if(value!.isEmpty){
                          return("Address can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid address");
                        }
                        return null;
                      },
                    ),//ADDRESS
                    const SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: darkblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(15),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          addData();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        }
                      },
                      child: const BoldFont("Save Profile", 16, white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

  }

  addData() async {
    final auth = FirebaseAuth.instance;
    final useruid= auth.currentUser!.uid;
    final docUser = FirebaseFirestore.instance.collection("userInfo").doc(useruid);


    final demoData = UserData(
      id: docUser.id,
      userphoto: photoUrl,
      name: name.text,
      phoneNumber: phone.text,
      email: email.text,
      address: address.text,
    );
    final json = demoData.toJson();
    await docUser.set(json);
  }

}


class UserData {
  String id;
  String userphoto;
  String name;
  String phoneNumber;
  String email;
  String address;

  UserData({
    required this.id,
    required this.userphoto,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.address,
  });

  Map<String, dynamic> toJson() {
    return {

      'id': id,
      'userphoto': userphoto,
      'name': name,
      'phoneNumber': phoneNumber,
      'email': email,
      'address':address,
    };
  }

  static UserData fromJson(Map<String, dynamic> json) => UserData(
      id: json['id'],
      userphoto: json['userphoto'],
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      address: json['address']
  );
}