import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_your_product.dart';
import 'package:meditech_rent/Screens/home_screen.dart';
import 'package:meditech_rent/centralized.dart';
import 'browsing_product.dart';

class EditRemoveProduct extends StatefulWidget {
  const EditRemoveProduct({Key? key}) : super(key: key);

  @override
  State<EditRemoveProduct> createState() => _EditRemoveProductState();
}

class _EditRemoveProductState extends State<EditRemoveProduct> {
  final useruid= FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: white,
          title: const BoldFont("Your Products", 20, darkblue),
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
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Align(
                    alignment: Alignment.topLeft,
                    child: BoldFont("All your products will appear here", 16, Colors.black45)),
                const SizedBox(height: 20),
                Expanded(
                  child: SizedBox(
                    // height: MediaQuery.of(context).size.height * 0.73,
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("profileInfo")
                            .where('Useruid', isEqualTo:useruid ).snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final userSnap = snapshot.data! as QuerySnapshot;
                            return ListView.builder(
                                itemCount: userSnap.docs.length,
                                itemBuilder: ((context, index) {
                                  final userData = userSnap.docs[index].data()
                                      as Map<String, dynamic>;
                                  return myList(
                                      userData['title'],
                                      userData['imageurl'],
                                      userData['rent'],
                                      userData['id']);
                                }));
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }),
                  ),
                ),
                MaterialButton(
                  elevation: 0,
                  color: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(10),
                  minWidth: MediaQuery.of(context).size.width/1.2,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()));
                  },
                  child: const BoldFont("Save Changes", 18, white),
                ),
              ],
            ),
          ),
        ));
  }

  Widget myList(String title, String image, String description, String id) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 90,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: Colors.indigo,
                  image: DecorationImage(
                      image: NetworkImage(image), fit: BoxFit.fill)),
            ),
            const SizedBox(height: 30)
          ],
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldFont(title, 20, darkblue),
            const SizedBox(height: 5),
            PlainFont(description, 15, black),
            const SizedBox(height: 5),
            Row(
              children: [
                Edit(id),
                const SizedBox(width: 10),
                Delete(id),
              ],
            ),
            const SizedBox(
              height: 40,
            )
          ],
        )
      ],
    );
  }

  GestureDetector Delete(String id) {
    return GestureDetector(
        onTap: () {
          final docUser =
              FirebaseFirestore.instance.collection("profileInfo").doc(id);
          docUser.delete();
        },
        child: const BoldFont("Delete", 15, darkblue));
  }

  GestureDetector Edit(String id) {
    return GestureDetector(
        onTap: () {
          final docUser =
              FirebaseFirestore.instance.collection("profileInfo").doc(id);
          docUser.update({'desc': 'hello'});
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddYourProduct(id)));
        },
        child: const BoldFont("Edit", 15, darkblue));
  }
}

// body: Container(
      //   decoration: const BoxDecoration(
      //     gradient: LinearGradient(
      //       colors: <Color>[Colors.white, background],
      //       end: Alignment.bottomCenter,
      //       begin: Alignment.topCenter,
      //     ),
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
      //     child: Center(
      //       child: Column(
      //         children: [
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           const PlainFont(
      //               "Products you have added will be shown here", 15, black),
      //           const SizedBox(
      //             height: 50,
      //           ),
      //           Column(
      //             children: [
      //               myList("Product1", "assets/images/Tablet.png",
      //                   "this is my first product"),
      //               const SizedBox(
      //                 height: 50,
      //               ),
      //               const Divider(color: black,endIndent: 20),
      //               const SizedBox(
      //                 height: 50,
      //               ),
      //               myList("Procuct 2 title", "assets/images/tablet2.png",
      //                   "New one"),
      //             ],
      //           ),
      //           const SizedBox(
      //             height: 20,
      //           ),
      //           const Spacer(),
      //           MaterialButton(
      //             elevation: 0,
      //             color: darkblue,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(30),
      //             ),
      //             padding: const EdgeInsets.all(10),
      //             minWidth: MediaQuery.of(context).size.width,
      //             onPressed: () {},
      //             child: const BoldFont("Save Cahnges", 20, white),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      // ),

      //to be copied