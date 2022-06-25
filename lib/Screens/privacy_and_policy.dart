import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Privacy and Policy", 20, darkBlue),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
                    icon: const Icon(
            Icons.arrow_back_outlined,
            color: darkBlue,
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
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Center(
              child: Column(
                children: [
                  CircleAvatar(
                      radius: 70,
                      backgroundImage:
                          AssetImage("assets/images/MediTech-Rent.png")),
                  SizedBox(
                    height: 30,
                  ),