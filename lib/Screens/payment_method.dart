import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: white,
          elevation: 0,
          leading: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.arrow_back, color: darkblue, size: 30)),
          title: const BoldFont("Payment Method", 22, darkblue)),
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const PlainFont("Please select a payment method to continue "
                  "with your order", 17, black),
              const SizedBox(height: 10),
              Image.asset("assets/images/payment.png",
                  height: 430, width: MediaQuery.of(context).size.width),
              const Spacer(),
              MaterialButton(
                  elevation: 0, color: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        BoldFont("Continue", 17, white),
                      ],
                    ),
                  )
              )

            ],
          ),
        ),
      ),
    );
  }
}
