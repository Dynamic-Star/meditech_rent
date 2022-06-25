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