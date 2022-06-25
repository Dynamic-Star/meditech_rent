import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: white,
        title: const BoldFont("Privacy and Policy", 20, darkBlue),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },