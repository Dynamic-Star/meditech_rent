import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class Favourites extends StatefulWidget {
  const Favourites({Key? key}) : super(key: key);

  @override
  State<Favourites> createState() => _FavouritesState();
}

class _FavouritesState extends State<Favourites> {
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
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
            child: Column(
              children: [
                ParagraphText(
                    "Items you have added as favourites will be displayed here.",
                    blue,
                    15,
                    TextAlign.left),
                const SizedBox(height: 20),
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
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.delete,
                    color: darkblue,
                    size: 30,
                  ),
                )
              ],
            ),
            BoldFont("Short description", 12, black),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 10,
            )
          ],
        ),
      ],
    );
  }
}
