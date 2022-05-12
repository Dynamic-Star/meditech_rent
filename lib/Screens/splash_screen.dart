import 'dart:async';
import 'package:flutter/material.dart';
import 'package:meditech_rent/centralized.dart';
import 'welcome_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const WelcomeScreen())));
       }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[white, background],
              end: Alignment.bottomCenter,
              begin: Alignment.topCenter,
            ),
          ),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/images/MediTech-Rent.png", height: 140),
                const SizedBox(height: 30),
                const BoldFont("Welcome to", 20, blue),
                const SizedBox(height: 7),
                const BoldFont("Meditech-Rent", 20, darkblue),
                const SizedBox(height: 100),
                const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(darkblue),
                ),
                const Spacer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}