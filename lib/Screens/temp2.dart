ort 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_address.dart';
import 'package:meditech_rent/Screens/payment_method.dart';
import 'package:meditech_rent/centralized.dart';

class editRantDetail extends StatefulWidget {
  String tempStartDate;
  String tempEndDate;

  TextEditingController? startDate;
  TextEditingController? endDate;
  editRantDetail(this.tempEndDate, this.tempStartDate);

  @override
  State<editRantDetail> createState() => _editRantDetailState();
}

class _editRantDetailState extends State<editRantDetail> {
  @override
  void initState() {
    widget.startDate = TextEditingController(text: widget.tempStartDate);
    widget.endDate = TextEditingController(text: widget.tempEndDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("edit date", 20, darkblue),
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
                    if (!RegExp(r'^.{10,}$').hasMatch(value)) {
                      return ("Invalid number (10 digits required)");
                    }
                    return null;
                  },
                  controller: widget.startDate,
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
                ),
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
                    if (!RegExp(r'^.{10,}$').hasMatch(value)) {
                      return ("Invalid number (10 digits required)");
                    }
                    return null;
                  },