import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Notifications", 20, darkBlue),
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
            padding: const EdgeInsets.all(18),
            child: Column(
              children: [
                const SizedBox(height: 10),
                notifications("assets/images/MediTech-Rent.png", "New products added", "Check new products for rent"),
                const SizedBox(height: 18),
                notifications("assets/images/MediTech-Rent.png", "Meditech Rent new offers", "Check out amazing offers on new products")

              ],
            ),
          ),
        ),
      ),
    );
  }
  Widget notifications(String image, String title, String subtitle){
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(color: hint, spreadRadius: 1)
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            const SizedBox(width: 7),
            CircleAvatar(
              radius: 20,
              child: Image.asset(image),
            ),
            const SizedBox(width: 18),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 4),
                BoldFont(title, 14, Colors.black54),
                PlainFont(subtitle, 12, darkBlue),
              ],
            )
          ],
        ),
      ),
    );
  }
}
