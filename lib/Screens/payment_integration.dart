import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:meditech_rent/centralized.dart';

class paymentIntegration extends StatefulWidget {
  String startDate;
  String endDate;
  paymentIntegration(this.startDate, this.endDate);

  @override
  _paymentIntegrationState createState() => _paymentIntegrationState();
}

class _paymentIntegrationState extends State<paymentIntegration> {
  Map<String, dynamic>? paymentIntentData;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BoldFont("Payment", 20, white),
        backgroundColor: darkBlue,
        elevation: 0,
      ),
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
                child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const PlainFont(
                  "Thanks for renting with us !!", 15, Colors.black54),
              const PlainFont(
                  "Checkout and do your payment from below", 15, black),
              const PlainFont(
                  "Correct details are necessary for payment", 15, darkBlue),
              const SizedBox(height: 30),
              InkWell(
                onTap: () async {
                  await makePayment();
                  // addData();
                },
                child: Container(
                  height: 50,
                  width: 200,
                  color: darkBlue,
                  child: const Center(
                      child: PlainFont("Proceed to pay", 18, white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment() async {
        try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  applePay: true,
                  googlePay: true,
                  testEnv: true,
                  style: ThemeMode.dark,
                  merchantCountryCode: 'ID',
                  merchantDisplayName: 'suraj'))
          .then((value) {});

      ///now finally display payment sheeet

      displayPaymentSheet();
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance
          .presentPaymentSheet(
              parameters: PresentPaymentSheetParameters(
        clientSecret: paymentIntentData!['client_secret'],
        confirmPayment: true,
      ))
          .then((newValue) {
        print('payment intent' + paymentIntentData!['id'].toString());
        print(
            'payment intent' + paymentIntentData!['client_secret'].toString());
        print('payment intent' + paymentIntentData!['amount'].toString());
        print('payment intent' + paymentIntentData.toString());
        //orderPlaceApi(paymentIntentData!['id'].toString());
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("paid successfully")));

        paymentIntentData = null;