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

class editYourProduct extends StatefulWidget {
  String Documenttitle;
  String Documentimage;
  String Documentrent;
  String Documentid;

  editYourProduct(this.Documenttitle, this.Documentimage, this.Documentrent,
      this.Documentid);

  @override
  State<editYourProduct> createState() => _editYourProductState();
}

class _editYourProductState extends State<editYourProduct> {
  TextEditingController? title;
  TextEditingController? desc;
  TextEditingController? rentDay;
  var savePhoto;

  @override
  void initState() {
    super.initState();
    title = TextEditingController(text: widget.Documenttitle);
    desc = TextEditingController(text: 'Add your desc');
    rentDay = TextEditingController(text: widget.Documentrent);
    savePhoto = widget.Documentimage;
  }

  late Map data;
  String photoUrl = "";
  File? imageFile;
  String? imageUrl;
  bool flag = false;

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

    if (image == '') return;

    var gg = "";
    var uuid = const Uuid();
    setState(() {
      gg = uuid.v1();
    });

    var snapshot =
        await firebaseStorage.ref("hello").child("images$gg").putFile(image);
    var downloadUrl = await snapshot.ref.getDownloadURL();
    log(downloadUrl);
    setState(() {
      photoUrl = downloadUrl;
      imageUrl = downloadUrl;
    });
  }

  //form key
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("edit Product", 20, darkblue),
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
                    const BoldFont("Add your product on Meditech-Rent", 17,
                        Colors.black45),
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
                          onTap: () {
                            PickImage();
                            setState(() {
                              flag = true;
                            });
                          },
                          child: Container(
                            height: 90,
                            width: 140,
                            margin: const EdgeInsets.all(15.0),
                            decoration: const BoxDecoration(
                              color: background,
                            ),
                            child: flag == false
                                ? Center(
                                    child: Image.network(savePhoto),
                                  )
                                : Image.file(imageFile!),
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Flexible(
                            fit: FlexFit.loose,
                            child:
                                BoldFont("Upload product image", 18, darkblue)),
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

                      // initialValue: "hello",
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
                        if (value!.isEmpty) {
                          return ("Title can't be empty");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please enter a valid Title (min 3 char)");
                        }
                        return null;