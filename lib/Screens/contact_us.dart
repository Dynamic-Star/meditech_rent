import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Contact Us", 20, darkBlue),
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
            child: Column(
              children: [
                Contact(
                    'Md Roknuzzaman Rasel ',
                    "Email : rasel@graduate.utm.my",
                    "assets/images/Md Roknuzzaman Rasel .jpeg"),
                SizedBox(
                  height: 20,
                ),
                Divider(color: hint),
                SizedBox(
                  height: 20,
                ),
                Contact(
                    'Md Roknuzzaman Rasel ',
                    "Email : rasel@graduate.utm.my",
                    "assets/images/Md Roknuzzaman Rasel .jpeg"),
                SizedBox(
                  height: 20,
                ),
                Divider(color: hint),
                SizedBox(
                  height: 20,
                ),
                Contact(
                    'Md Roknuzzaman Rasel ',
                    "Email : rasel@graduate.utm.my",
                    "assets/images/Md Roknuzzaman Rasel .jpeg"),
                SizedBox(
                  height: 20,
                ),
                Divider(color: hint),
                SizedBox(
                  height: 20,
                ),
                Contact(
                    'Md Roknuzzaman Rasel ',
                    "Email : rasel@graduate.utm.my",
                    "assets/images/Md Roknuzzaman Rasel .jpeg"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget Contact(
    String Name,
    String Email,
    String image,
  ) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(radius: 70, backgroundImage: AssetImage(image)),
          SizedBox(
            height: 20,
          ),
          BoldFont(Name, 17, darkBlue),
          BoldFont(Email, 17, Colors.black54)
        ],
      ),
    );
  }
}
