import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/buyer_profile.dart';
import 'package:meditech_rent/Screens/seller_profile.dart';
import 'package:meditech_rent/centralized.dart';

class BuyerSeller extends StatefulWidget {
  const BuyerSeller({Key? key}) : super(key: key);

  @override
  State<BuyerSeller> createState() => _BuyerSellerState();
}

class _BuyerSellerState extends State<BuyerSeller> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(children: [
            const Spacer(),
            Image.asset("assets/images/MediTech-Rent.png", height: 140),
            const SizedBox(height: 30),
            const BoldFont("Thanks for Registering with", 20, blue),
            const SizedBox(height: 5),
            const BoldFont("Meditech-Rent", 20, darkblue),
            const Spacer(),
            MaterialButton(
              elevation: 0,
              color: darkblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) => const Buyer()));
              },
              child: const BoldFont("Continue as Buyer", 16, white),
            ),
            const SizedBox(height: 50),
            MaterialButton(
              elevation: 0,
              color: darkblue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              padding: const EdgeInsets.all(15),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                Navigator.push(context,MaterialPageRoute(
                        builder: (context) => const Seller()));
              },
              child: const BoldFont("Continue as Seller", 16, white),
            ),
           const Spacer()
          ]),
        ),
      ),
    );
  }
}
