import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_address.dart';
import 'package:meditech_rent/Screens/payment_method.dart';
import 'package:meditech_rent/Screens/temp2.dart';
import 'package:meditech_rent/centralized.dart';

class YourCart extends StatefulWidget {
  String startDate;
  String endDate;
  YourCart(this.startDate, this.endDate);

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
      body: Stack(
        children:[
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("cardInfo")
                .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                .snapshots(),
            builder: ((context, snapshot) {
              if (snapshot.hasData) {
                final userSnap = snapshot.data! as QuerySnapshot;
                return Container(
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
                    child: ListView.builder(
                        itemCount: userSnap.docs.length,
                        itemBuilder: ((context, index) {
                          final userData =
                              userSnap.docs[index].data() as Map<String, dynamic>;
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Container(
                                        height: 90,
                                        width: 120,
                                        decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                  color: hint,
                                                  spreadRadius: 1,
                                                  blurRadius: 1)
                                            ],
                                            borderRadius: BorderRadius.circular(15),
                                            // color: Colors.indigo,
                                            image: DecorationImage(
                                                image: NetworkImage(userData['image']),
                                                fit: BoxFit.cover)),
                                      ),
                                      const SizedBox(height: 30)
                                    ],
                                  ),
                                  // const SizedBox(height: 30),
                                  const SizedBox(width: 18),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(height: 10),
                                      BoldFont(userData['title'], 18, darkblue),
                                      PlainFont(userData['rent'], 16, black),
                                      PlainFont(widget.startDate, 16, black),
                                      PlainFont(widget.endDate, 16, black),

                                      // const SizedBox(height: 5),
                                      Row(
                                        children: [
                                          TextButton(
                                            onPressed: () {
                                              final docUser = FirebaseFirestore
                                                  .instance
                                                  .collection("cardInfo")
                                                  .doc(userData['id']);
                                              docUser.delete();
                                            },
                                            child: const BoldFont(
                                                "Remove", 16, darkblue),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          editRantDetail(
                                                              widget.startDate,
                                                              widget.endDate)));
                                            },
                                            child:
                                                const BoldFont("Edit", 16, darkblue),
                                          ),
                                          // TextButton(
                                          //   onPressed: () {
                                          //     Navigator.push(
                                          //         context,
                                          //         MaterialPageRoute(
                                          //             builder: (context) =>
                                          //                 const PaymentMethod()));
                                          //   },
                                          //   child: const BoldFont(
                                          //       "Continue", 16, darkblue),
                                          // ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 40,
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          );
                        })),
                  ),
                );
              } else {
                return const Center(
                  child: Text("Add Some Products"),
                );
              }
            })),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              children: [
                Spacer(),
                MaterialButton(
                    elevation: 0, color: white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        side: const BorderSide(color: darkblue)
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const PaymentMethod()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Row(
                        children: const [
                          Spacer(),
                          BoldFont("Place Order", 16, darkblue),
                          Spacer(),
                        ],
                      ),
                    )
                ),
              ],
            ),
          ),
    ],
      ),
    );
  }

  Widget myList(
    BuildContext context,
    String image,
    String Product,
  ) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(15),
          ),
          child: SizedBox(
            width: 90,
            height: 100,
            child: Image.asset(image),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                BoldFont(Product, 17, darkblue),
                const SizedBox(width: 30),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            const BoldFont("Short description", 12, black),
            const SizedBox(
              height: 5,
            ),
            GestureDetector(
              onTap: () {},
              child: const BoldFont("Remove Item", 15, darkblue),
            ),
            const SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }
}

GestureDetector Delete(String id) {
  return GestureDetector(
      onTap: () {
        final docUser =
            FirebaseFirestore.instance.collection("cardInfo").doc(id);
        docUser.delete();
      },
      child: const BoldFont("Delete", 15, darkblue));
}
