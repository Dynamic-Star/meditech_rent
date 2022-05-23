import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_your_product.dart';
import 'package:meditech_rent/centralized.dart';

class CancelOrder extends StatefulWidget {
  const CancelOrder({Key? key}) : super(key: key);

  @override
  State<CancelOrder> createState() => _CancelOrderState();
}

class _CancelOrderState extends State<CancelOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Cancel Order", 20, darkblue),
        leading: IconButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>  AddYourProduct()));
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
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22, 0, 22, 30),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                const PlainFont("Your recent order are displayed here.", 15, blue),
                const SizedBox(
                  height: 50,
                ),
                Column(
                  children: [
                    myList("Product 1 Title", "assets/images/Tablet.png",
                        "this is my first product"),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 50,
                ),
                const PlainFont("Enter reason for cancellation", 15, black),
                const SizedBox(
                  height: 10,
                ),
                const TextField(
                  decoration: InputDecoration(
                    fillColor: white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: blue,
                          width: 2.0,
                        )),
                    contentPadding: EdgeInsets.all(10),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Spacer(),
                MaterialButton(
                  elevation: 0,
                  color: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.all(10),
                  minWidth: MediaQuery.of(context).size.width,
                  onPressed: () {},
                  child: const BoldFont("Cancel Order", 20, white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Image Lists
  Widget myList(String title, String image, String description) {
    return Row(
      children: [
        Container(
          height: 90,
          width: 140,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image:
                  DecorationImage(image: AssetImage(image), fit: BoxFit.fill)),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldFont(title, 20, darkblue),
            const SizedBox(height: 10),
            PlainFont(description, 15, black),
            const SizedBox(height: 10),
            const BoldFont("Placed on 2 April, 2022", 15, blue),
          ],
        )
      ],
    );
  }
}
