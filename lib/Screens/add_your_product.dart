import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meditech_rent/Screens/edit_remove_product.dart';
import 'package:meditech_rent/centralized.dart';
import 'package:uuid/uuid.dart';

class AddYourProduct extends StatefulWidget {

  String? Documentid;

  AddYourProduct([this.Documentid]);

  @override
  State<AddYourProduct> createState() => _AddYourProductState();
}

class _AddYourProductState extends State<AddYourProduct> {
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController rentDay = TextEditingController();

  late Map data;
  String photoUrl = "";
  File? imageFile;
  String? imageUrl;

  Future PickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        imageFile = imageTemporary;
      });
      uploadPhoto(imageFile!);
    } on PlatformException catch (e) {
      print("Failed to pick image $e");
    }
  }

  Future<void> uploadPhoto(File image) async {
    final firebaseStorage = FirebaseStorage.instance;
    final auth = FirebaseAuth.instance;

    if (image == null) return;

    if (image != null) {
      var gg = "";
      var uuid = const Uuid();
      setState(() {
        gg = uuid.v1();
      });
     
      var snapshot = await firebaseStorage
          .ref("hello")
          .child("images$gg")
          
       
          .putFile(image);
      var downloadUrl = await snapshot.ref.getDownloadURL();
      log(downloadUrl);
      setState(() {
        photoUrl = downloadUrl;
        imageUrl = downloadUrl;
      });
    }
  }

  //form key
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Add Product", 20, darkblue),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: darkblue,
            size: 30,
          ),
        ),
        elevation: 0.0,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BoldFont(
                        "Add your product on Meditech-Rent", 17, Colors.black45),
                    const SizedBox(
                      height: 30,
                    ),
                    const PlainFont(
                        "Choose an image showing the overview of your product",
                        16,
                        Colors.black45),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () => PickImage(),
                          child: Container(
                            height: 90,
                            width: 140,
                            margin: const EdgeInsets.all(15.0),
                            decoration: BoxDecoration(
                              color: background,
                            ),
                            child: Center(
                              child: imageFile == null
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.add_outlined,
                                      ),
                                      iconSize: 50,
                                      color: hint,
                                      onPressed: () => PickImage(),
                                    )
                                  : Image.file(
                                      imageFile!,
                                      height: 90,
                                      width: 140,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Flexible(
                            fit: FlexFit.loose,
                            child: BoldFont("Upload product image", 18, darkblue)),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const PlainFont("Add product Title", 15, black),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: title,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: blue,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if(value!.isEmpty){
                          return("Title can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid Title (min 3 char)");
                        }
                        return null;
                      },
                      // onChanged: (value){
                      //   setState(() {
                      //     title.text = value.toString();
                      //     proTitle = title.text;
                      //   });
                      //   log(proTitle);
                      // },
                    ),//Title Field

                    const SizedBox(
                      height: 20,
                    ),
                    const PlainFont("Add product Description", 15, black),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      minLines: 3,
                      maxLines: 5,
                      maxLength: 50,
                      keyboardType: TextInputType.multiline,
                      controller: desc,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: blue,
                          width: 2.0,
                        )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if(value!.isEmpty){
                          return("Description can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid description (min 7 char)");
                        }
                        return null;
                      },
                    ),//Description Field

                    const SizedBox(
                      height: 20,
                    ),
                    const PlainFont("Add Rent per day", 15, black),
                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      controller: rentDay,
                      decoration: const InputDecoration(
                        fillColor: white,
                        filled: true,
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                          color: blue,
                          width: 2.0,
                        )),
                        contentPadding: EdgeInsets.all(10),
                      ),
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if(value!.isEmpty){
                          return("Rent value can't be empty");
                        }
                        if(!regex.hasMatch(value)){
                          return("Please enter a valid rent");
                        }
                        return null;
                      },
                    ),//Rent per day

                    const SizedBox(
                      height: 50,
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: darkblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.all(10),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        if(_formkey.currentState!.validate()){
                          addData(widget.Documentid);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const EditRemoveProduct()));
                        }
                      },
                      child: const BoldFont("Add Product", 20, white),
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

  addData(String? id) async {
    final docUser = FirebaseFirestore.instance.collection("profileInfo").doc();
    final auth = FirebaseAuth.instance;
    final useruid= auth.currentUser!.uid;
    
    final demoData = User(
        id: docUser.id,
        imageurl: photoUrl,
        title: title.text,
        desc: desc.text,
        rent: rentDay.text,
        Useruid: useruid,
        );
    final json = demoData.toJson();
    await docUser.set(json);
  }
}

fetchData() {
  final fire = FirebaseFirestore.instance;

  CollectionReference collectionReference = fire.collection("profileInfo");

  collectionReference.snapshots().listen((snapshort) {});
}

//model

class User {
  String? id;
  String imageurl;
  String title;
  String desc;
  String? rent;
  String Useruid;

  User({
    required this.id,
    required this.imageurl,
    required this.title,
    required this.desc,
    required this.rent,
    required this.Useruid,
  });

  Map<String, dynamic> toJson() {
    return {
      
      'id': id,
      'imageurl': imageurl,
      'title': title,
      'desc': desc,
      'rent': rent,
      'Useruid':Useruid,
    };
  }

  static User fromJson(Map<String, dynamic> json) => User(
        id: json['id'],
        imageurl: json['imageurl'],
        title: json['title'],
        desc: json['desc'],
        rent: json['rent'],
        Useruid: json['Useruid']
      );
}
