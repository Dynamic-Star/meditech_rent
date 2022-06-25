import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/temperary.dart';
import 'package:meditech_rent/centralized.dart';

class AddRantDetail extends StatefulWidget {
  String startDate;
  String endDate;
  AddRantDetail(this.startDate,this.endDate);

  @override
  State<AddRantDetail> createState() => _AddRantDetailState();
}

class _AddRantDetailState extends State<AddRantDetail> {
  //form key
  final _formkey = GlobalKey<FormState>();

  //editing controllers
  TextEditingController startDate = TextEditingController();
  TextEditingController endDate = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Add rent details", 20, darkblue),
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
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  const PlainFont(
                      "Enter more details of your renting", 16, black),
                  const SizedBox(
                    height: 15,
                  ),
                  ParagraphText(
                      "Note : Minimum rent period will be 30 days.\n            Add your date in accordance with this.",
                      blue,
                      16,
                      TextAlign.left),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: BoldFont("Start date", 18, darkblue)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please fill start date");
                        }
                        if (!RegExp(r'^.{7,}$').hasMatch(value)) {
                          return ("Invalid number (7 digits required)");
                        }
                        return null;
                      },
                      controller: startDate,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(
                            color: blue,
                            width: 1.0,
                          ),
                        ),
                        hintText: "Enter start date",
                        hintStyle: const TextStyle(
                            color: hint,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                        contentPadding: const EdgeInsets.all(13),
                      ),
                      onSaved: (value) {
                        startDate.text = value!;
                      },
                      textInputAction: TextInputAction.next),
                  const SizedBox(
                    height: 30,
                  ),
                  const Align(
                      alignment: Alignment.bottomLeft,
                      child: BoldFont("End date", 18, darkblue)),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return ("Please Fill End Date");
                        }
                        if (!RegExp(r'^.{7,}$').hasMatch(value)) {
                          return ("Invalid number (7 digits required)");
                        }
                        return null;
                      },
                      controller: endDate,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(13),
                          borderSide: const BorderSide(
                            color: blue,
                            width: 1.0,
                          ),
                        ),
                        hintText: "Enter start date",
                        hintStyle: const TextStyle(
                            color: hint,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins'),
                        contentPadding: const EdgeInsets.all(13),
                      ),
                      onSaved: (value) {
                        endDate.text = value!;
                      },
                      textInputAction: TextInputAction.done),
                  const SizedBox(
                    height: 50,
                  ),
                  const BoldFont("Your total cart price per 30 days = \$ 100",
                      16, darkblue),
                  const SizedBox(
                    height: 100,
                  ),
                  MaterialButton(
                      elevation: 0,
                      color: darkblue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                      onPressed: () {
                        if (_formkey.currentState!.validate()) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YourCart(
                                      widget.startDate, widget.endDate)));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(11.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            BoldFont("Continue", 18, white),
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
