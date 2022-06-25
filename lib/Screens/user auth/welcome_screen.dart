import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/splash_screen.dart';
import 'package:meditech_rent/centralized.dart';
import 'email_password_login.dart';
import 'google_email_phone.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SplashScreen();
    return Scaffold(
      body: Container(
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset("assets/images/MediTech-Rent.png", height: 120),
              const SizedBox(height: 30),
              const BoldFont("Welcome to", 19, blue),
              const SizedBox(height: 4),
              const BoldFont("Meditech-Rent", 19, darkblue),
              const SizedBox(height: 20),
              const PlainFont("Get any medical product on rent instantly.", 15, darkblue),
              const SizedBox(height: 5),
              const PlainFont("Join Us Now !!", 15, darkblue),
              const Spacer(),
              MaterialButton(
                  elevation: 0, color: darkblue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ContinueOption()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      children: const [
                        Spacer(),
                        BoldFont("Register", 16, white),
                        Spacer(),
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              MaterialButton(
                  elevation: 0, color: white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: darkblue)
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const EmailLogIn()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Row(
                      children: const [
                        Spacer(),
                        BoldFont("Sign In", 16, darkblue),
                        Spacer(),
                      ],
                    ),
                  )
              ),
              const SizedBox(height: 20),
              // GestureDetector(
              //   onTap: (){
              //     Navigator.push(context, MaterialPageRoute(builder: (context) => const BuyerSeller()));
              //   },
                // child: const BoldFont("Skip for Now", 16, darkblue),
              // ),
          ],
          ),
        ),
      ),
    );
  }
}