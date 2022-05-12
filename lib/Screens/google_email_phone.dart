import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:meditech_rent/Screens/continue_buyer_seller.dart';
import 'package:meditech_rent/centralized.dart';
import '../google_firebase/fire_base_service.dart';
import 'email_password_register.dart';
import 'phone_otp_login.dart';

class ContinueOption extends StatefulWidget {
  @override
  State<ContinueOption> createState() => _ContinueOptionState();
}

class _ContinueOptionState extends State<ContinueOption> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [background, white],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              children: [
                const Spacer(),
                Image.asset("assets/images/MediTech-Rent.png", height: 140),
                const SizedBox(height: 30),
                const BoldFont("Welcome to", 20, blue),
                const BoldFont("Meditech-Rent", 20, darkblue),
                const SizedBox(height: 60),
                MaterialButton(
                  elevation: 0,
                  color: white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: darkblue)),
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    FirebaseService service = new FirebaseService();
                    try {
                      await service.signInwithGoogle();
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const BuyerSeller()));
                    } catch (e) {
                      if (e is FirebaseAuthException) {
                        const SnackBar(
                          content: Text("Error"),
                        );
                      }
                    }
                    setState(() {
                      isLoading = false;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/google.png",
                          height: 30,
                        ),
                        const Spacer(),
                        const BoldFont("Continue With Google", 17, darkblue),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  color: white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: darkblue)),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const EmailRegister()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/message.png",
                          height: 30,
                        ),
                        const Spacer(),
                        const BoldFont("Continue With Email", 17, darkblue),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                MaterialButton(
                  elevation: 0,
                  color: white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                      side: const BorderSide(color: darkblue)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => PhoneLogIn()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Row(
                      children: [
                        Image.asset(
                          "assets/images/call.png",
                          height: 30,
                        ),
                        const Spacer(),
                        const BoldFont("Continue With Phone", 17, darkblue),
                        const Spacer()
                      ],
                    ),
                  ),
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
