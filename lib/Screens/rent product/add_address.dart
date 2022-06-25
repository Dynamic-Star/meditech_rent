import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class AddAddress extends StatefulWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  State<AddAddress> createState() => _AddAddressState();
}

class _AddAddressState extends State<AddAddress> {

  TextEditingController addressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController landmarkController = TextEditingController();

  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    final addressField = TextFormField(
      keyboardType: TextInputType.text,
      controller: addressController,
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
        hintText: "Full Address",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Poppins'),
        contentPadding: const EdgeInsets.all(16),
      ),
    );

    final cityCodeField = TextFormField(
      keyboardType: TextInputType.text,
      controller: cityController,
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
        hintText: "Enter City and Zip Code",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Poppins'),
        contentPadding: const EdgeInsets.all(16),
      ),
    );

    final landmarkField = TextFormField(
      keyboardType: TextInputType.text,
      controller: landmarkController,
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
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 18, fontFamily: 'Poppins'),
        contentPadding: const EdgeInsets.all(16),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: darkblue, size: 30)),
          title: const BoldFont("Add Address", 22, darkblue)),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[
              Colors.white24,
              Color(0xFFCAEEFF),
            ],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  const PlainFont("Add a delivery address for your order.", 17, darkblue),
                  const SizedBox(height: 10),
                  Image.asset("assets/images/address.png",
                      height: 200, width: MediaQuery.of(context).size.width),
                  const SizedBox(height: 50),
                  addressField,
                  const SizedBox(height: 20),
                  cityCodeField,
                  const SizedBox(height: 20),
                  landmarkField,
                  const SizedBox(height: 150),
                  MaterialButton(
                  elevation: 0, color: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        BoldFont("Save and Continue", 17, white),
                      ],
                    ),
                  )
              )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
