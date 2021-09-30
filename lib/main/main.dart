import 'package:flutter/material.dart';
import 'package:flutter_testing_proj/pages/cart.dart';
import 'package:flutter_testing_proj/pages/home.dart';
import 'package:flutter_testing_proj/pages/login.dart';
import 'package:flutter_testing_proj/pages/mobile_detail.dart';
import 'package:flutter_testing_proj/pages/on_boarding.dart';
import 'package:flutter_testing_proj/pages/signup.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        themeMode: ThemeMode.system,
        theme: MyThemes.lightTheme(context),
        darkTheme: MyThemes.darkTheme(context),
        debugShowCheckedModeBanner: false,
        // initialRoute: "/home",
        routes: {
          "/": (context) => const OnBoarding(),
          "/login": (context) => const Login(),
          "/signup": (context) => const Signup(),
          "/home": (context) => const Home(),
          "/mobiles_detail": (context) => const MobileDetail(),
          "/cart": (context) => const Cart()
        });
  }
}
