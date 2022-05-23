import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_your_product.dart';
import 'package:meditech_rent/Screens/browsing_product.dart';
import 'package:meditech_rent/Screens/edit_remove_product.dart';
import 'package:meditech_rent/Screens/favourites.dart';
import 'package:meditech_rent/Screens/rent_now.dart';
import 'package:meditech_rent/Screens/user_profile.dart';
import 'package:meditech_rent/centralized.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectIndex = 0;

  List mainPages = const [
    HomeScreenBody(),
    BrowseProduct(),
    UserProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: white,
        title: Row(
          children: [
            Image.asset("assets/images/MediTech-Rent.png", height: 40),
            const SizedBox(width: 15),
            const BoldFont("Meditech-Rent", 21, darkblue),
            const Spacer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.notifications, color: hint, size: 30),
            )
          ],
        ),
      ),
      body: mainPages[selectIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        backgroundColor: darkblue,
        currentIndex: selectIndex,
        onTap: (index) {
          setState(() {
            selectIndex = index;
          });
        },
        selectedFontSize: 0,
        selectedItemColor: background,
        unselectedItemColor: white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded, size: 35),
              label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 35),
              label: ""),
        ],
      ),
    );
  }
}

class HomeScreenBody extends StatefulWidget {
  const HomeScreenBody({Key? key}) : super(key: key);

  @override
  State<HomeScreenBody> createState() => _HomeScreenBodyState();
}

class _HomeScreenBodyState extends State<HomeScreenBody> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
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
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
          child: Column(
            children: [
              TextField(
                  style: const TextStyle(
                      color: darkblue, fontFamily: 'Poppins', fontSize: 18),
                  autofocus: false,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon:
                    const Icon(Icons.search, color: hint, size: 30),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13.0),
                      borderSide: const BorderSide(
                        color: blue,
                        width: 2.0,
                      ),
                    ),
                    fillColor: white,
                    filled: true,
                    contentPadding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                    hintText: "Search",
                    hintStyle: const TextStyle(
                        fontFamily: "Poppins", color: hint, fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  textInputAction: TextInputAction.done),
              const SizedBox(height: 30),
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: false,
                  viewportFraction: 1,
                  disableCenter: false,
                  enableInfiniteScroll: false,
                  autoPlayInterval: const Duration(seconds: 3),
                  aspectRatio: 2.1,
                  enlargeCenterPage: true,
                  onPageChanged: (index, a) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
                items: [
                  myCarouselItems("assets/images/carousel-1.png", ""),
                  myCarouselItems("assets/images/address.png", ""),
                  myCarouselItems("assets/images/tablets.png", ""),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (var i = 0; i < 3; i++)
                    Container(
                      width: 12,
                      height: 12,
                      margin: const EdgeInsets.symmetric(horizontal: 3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _current == i ? darkblue : hint),
                    )
                ],
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myTiles("Rent Now", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RentNow()));
                  }),
                  myTiles("Add\nProduct", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddYourProduct()));
                  }),
                  myTiles("Your\nProducts", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EditRemoveProduct()));
                  }), //Route to add products
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  myTiles("Favourites", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Favourites()));
                  }),
                  myTiles("Privacy\nPolicy", () {}),
                  myTiles("Contact Us", () {}),
                ],
              ),
              const SizedBox(height: 50),
              const Align(
                alignment: Alignment.topLeft,
                child: BoldFont("  Categories", 20, darkblue),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  categories("assets/images/tablets.png", () {
                    debugPrint("Clicked me");
                  }),
                  categories("assets/images/ayurvedic.png", () {}),
                  categories("assets/images/tablets2.png", () {}),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget myTiles(String text, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 100,
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: darkblue, spreadRadius: 1),
          ],
          color: white,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BoldFont(text, 15, darkblue),
          ),
        ),
      ),
    );
  }// Tiles Items
  Widget categories(String images, onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 140,
        width: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            image:
            DecorationImage(image: AssetImage(images), fit: BoxFit.cover)),
      ),
    );
  }//Categories
  Widget myCarouselItems(String image, String text) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(1, 2), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(14.0),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          )),
      child: Center(
        child: Text(
          text,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
    );
  }//Carousel items
}

