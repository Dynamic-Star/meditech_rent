import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class ConfirmOrider extends StatefulWidget {
  const ConfirmOrider({Key? key}) : super(key: key);

  @override
  State<ConfirmOrider> createState() => _ConfirmOriderState();
}

class _ConfirmOriderState extends State<ConfirmOrider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Payment", 20, darkblue),
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
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: <Color>[Colors.white, background],
            end: Alignment.bottomCenter,
            begin: Alignment.topCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BoldFont("Delivery Address", 15, darkblue),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.location_on,
                    color: darkblue,
                    size: 30,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  ParagraphText(
                      "Full davilery address details line1\nCity name, Zip Code\nAdditionl Landmark",
                      black,
                      16,
                      TextAlign.left),
                  Spacer(),
                  GestureDetector(
                    onTap: () {},
                    child: BoldFont("Edit", 17, darkblue),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: hint,
              ),
              SizedBox(
                height: 20,
              ),
              BoldFont("Payment Method", 15, darkblue),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Icon(Icons.account_balance_wallet_rounded, color: darkblue),
                  Spacer(),
                  Image.asset("assets/images/Visa_Inc._logo 1.png"),
                  BoldFont("**** **** ****5967", 15, black),
                  Spacer(),
                  GestureDetector(
                    child: BoldFont("Edit", 15, darkblue),
                  )
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: hint,
              ),
              SizedBox(
                height: 20,
              ),
              newList("item Total", "\$ 280"),
              SizedBox(
                height: 20,
              ),
              newList("Delivery Charge", "\$ 10"),
              SizedBox(
                height: 20,
              ),
              newList("Additional taxes", "\$ 2"),
              SizedBox(
                height: 20,
              ),
              Divider(
                thickness: 1,
                color: hint,
              ),
              SizedBox(
                height: 20,
              ),
              newList("Item Total", "\$ 292"),
              Spacer(),
              MaterialButton(
                elevation: 0,
                color: darkblue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.all(10),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () {},
                child: const BoldFont("Place Order", 20, white),
              ),
              SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget newList(String text, String price) {
    return Row(
      children: [
        BoldFont(text, 15, black),
        Spacer(),
        BoldFont(price, 15, darkblue)
      ],
    );
  }
}
