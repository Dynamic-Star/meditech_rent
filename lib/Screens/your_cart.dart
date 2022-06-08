import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_rent_detail.dart';
import 'package:meditech_rent/centralized.dart';

class YourCart extends StatefulWidget {
  String startDate;
  String endDate;
  String title;
  String rent;
  String image;

  YourCart(this.startDate,this.endDate,this.title, this.rent, this.image);
  @override
  State<YourCart> createState() => _YourCartState();
}

class _YourCartState extends State<YourCart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Your Cart", 20, darkblue),
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
         child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
               stream: FirebaseFirestore.instance
                  .collection("cardInfo")
                  .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  final userSnap = snapshot.data! as QuerySnapshot;
                  return ListView.builder(
                      itemCount: userSnap.docs.length,
                      itemBuilder: ((context, index) {
                        final userData =
                            userSnap.docs[index].data() as Map<String, dynamic>;
                        return Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: