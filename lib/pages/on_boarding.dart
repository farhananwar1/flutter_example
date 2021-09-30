import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text("OnBoarding"),
    //   ),
    //   body: Center(
    //     child: Container(
    //       child: Text("yyfgyufuyfyuf"),
    //     ),
    //   ),
    //   drawer: Drawer(),
    // );
    return Material(
      color: context.canvasColor,
      child: Column(
        children: [
          const SizedBox(
            height: 100.0,
          ),
          Text("Welcome",
              style: TextStyle(
                  color: context.accentColor,
                  fontSize: 50,
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 50.0,
          ),
          Image.asset("assets/images/login.png"),
          const SizedBox(
            height: 40.0,
          ),
          Container(
            margin: const EdgeInsets.only(top: 20.0),
            child: ElevatedButton(
              child: Text(
                "Login",
                style: TextStyle(
                    color: MyThemes.creamColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              style: TextButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  backgroundColor: context.theme.buttonColor),
              onPressed: () {
                Navigator.pushNamed(context, "/login");
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5.0),
            child: ElevatedButton(
              child: Text(
                "SignUp",
                style: TextStyle(
                    color: MyThemes.creamColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              style: TextButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  backgroundColor: context.theme.buttonColor),
              onPressed: () {
                Navigator.pushNamed(context, "/signup");
              },
            ),
          )
        ],
      ),
    );
  }
}
