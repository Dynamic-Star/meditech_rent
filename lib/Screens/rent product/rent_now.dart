import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/add_your_product.dart';
import 'package:meditech_rent/Screens/browsing_product.dart';
import 'package:meditech_rent/centralized.dart';

class RentNow extends StatelessWidget {
  const RentNow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Rent any product", 20, darkblue),
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
      bottomNavigationBar: BottomAppBar(
        color: darkblue,
        child: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddYourProduct()));
                  },
                  child: const BoldFont("Add your Product", 20, white)),
            ],
          ),
        ),
      ),
      body: const BrowseProduct(),
    );
  }
}
