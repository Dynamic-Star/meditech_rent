import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meditech_rent/Screens/continue_buyer_seller.dart';
import 'package:meditech_rent/Screens/splash_screen.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_cubit.dart';
import 'package:meditech_rent/phone_bloc/auth_cubit/auth_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //This initializes firebase in our app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: "Meditech-Rent",
        theme: ThemeData(primarySwatch: Colors.indigo),
        debugShowCheckedModeBanner: false,
        home:
            BlocBuilder<AuthCubit, AuthState>(buildWhen: (oldState, newState) {
          return oldState is AuthInitialState;
        }, builder: (context, state) {
          if (state is AuthLoggedInState) {
            return const BuyerSeller();
          } else if (state is AuthLoggedOutState) {
            return const SplashScreen();
          } else {
            return const SplashScreen();
          }
        }),
      ),
    );
  }
}
