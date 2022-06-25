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
                                                     Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ParagraphText(
                      "This Privacy Policy (“Privacy Policy”) describes what information The Cai Store, as owner of the Platform, may collect from a user (“You”, “Your” or “User”), on or through Our website (https://thecaistore.com/) (the “Site”) directly the owner of the Platform are referred collectively as “We”/ “Us”/ ”Our”) and how We use, process, disclose and try to protect such information."
                      "You agree and understand that the Company is responsible for operation and maintenance of the Platform and all information collected and processed on the Platform is collected and processed by Us strictly in relation to Our business."
                      "By using Our Platform, or the Services, You confirm that You have read, understood, and agree with the privacy practices described in this Privacy Policy, and the Terms of Use (the “Terms”) and the collection, storage and processing of Your information in accordance with them."
                      "This Privacy Policy is incorporated by reference into the Terms. Any capitalized terms used but not defined in this Privacy Policy have the meaning given to them in the Terms."
                      "This Privacy Policy is published in compliance with, inter alia:"
                      "Section 43A of the Information Technology Act, 2000 (“IT Act”)"
                      "Rule 4 of the Information Technology (Reasonable Security Practices and Procedures and Sensitive Personal Information) Rules, 2011 (“SPDI Rules”); and"
                      "Regulation 3(1) of the Information Technology (Intermediaries Guidelines and Digital Media Ethics Code) Rules, 2021 (“Intermediaries Guidelines”).",
                      darkBlue,
                      20,
                      TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
