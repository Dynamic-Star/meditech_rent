import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class Billings extends StatefulWidget {
  const Billings({Key? key}) : super(key: key);

  @override
  State<Billings> createState() => _BillingsState();
}

class _BillingsState extends State<Billings> {
  int selectIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Favourites", 20, darkblue),
        leading: IconButton(
          onPressed: () {},
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: ParagraphText(
                      "See your product's rentat billings and days left here.",
                      black,
                      14,
                      TextAlign.left),
                ),
                SizedBox(
                  height: 30,
                ),
                myList(context, "assets/images/med1.png", "Product 1 Title"),
                Divider(color: hint),
                myList(context, "assets/images/med5.png", "Product 1 Title"),
              ],
            ),
          ),
        ),
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
            const Radius.circular(15),
          ),
          child: Container(
            width: 100,
            height: 120,
            child: Image.asset(image),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BoldFont("Product 1 Title", 15, darkblue),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldFont("Start date", 12, black),
                Spacer(),
                BoldFont("01-03-2022", 12, darkblue),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldFont("End date", 12, black),
                Spacer(),
                BoldFont("31-03-2022", 12, darkblue),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BoldFont("Days left", 12, black),
                Spacer(),
                BoldFont("14 days", 12, darkblue),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
