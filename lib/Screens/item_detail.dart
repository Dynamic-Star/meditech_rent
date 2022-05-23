import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class ItemDetail extends StatefulWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  State<ItemDetail> createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  var size1, heigth, width;
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
        title: const BoldFont("Item Detail", 20, darkblue),
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
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        backgroundColor: darkblue,
        currentIndex: selectIndex,
        onTap: _onItemTapped,
        selectedFontSize: 0,
        selectedItemColor: background,
        unselectedItemColor: white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled, size: 35),
            label: "",
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_rounded, size: 35), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, size: 35), label: ""),
        ],
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Image.asset("assets/images/meditechfullpage.png",
                    fit: BoxFit.cover),
              ),
            ),
            Column(
              children: [
                const Spacer(),
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25)),
                  child: Container(
                    color: white,
                    height: 430,
                    width: MediaQuery.of(context).size.width,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoldFont("Paracitamole(15 tablets)", 15, darkblue),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            children: [
                              BoldFont("Daily rate: \$ 25", 12, darkblue),
                              SizedBox(
                                width: 30,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.orangeAccent),
                                width: 55,
                                height: 20,
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(5, 2, 5, 0),
                                  child: BoldFont("26 % OFF", 10, white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Divider(color: hint),
                          SizedBox(
                            height: 30,
                          ),
                          BoldFont("Description", 15, darkblue),
                          SizedBox(
                            height: 10,
                          ),
                          ParagraphText(
                              "Paracitamol is a common painkiller used to treat\naches and pain.It can also be used to reduce a high\ntemperature.It's valilable combined with other\npainkillers and anti-sickness medicines.it's also an\ningradient in a wide range of cold and flu remedies.",
                              hint,
                              15,
                              TextAlign.left),
                          SizedBox(height: 30),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Image.asset("assets/images/share.png"),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              BoldFont("Share This Item", 18, darkblue)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
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
            Row(
              children: [
                BoldFont(Product, 18, darkblue),
                const SizedBox(width: 40),
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
