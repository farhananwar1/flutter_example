import 'package:flutter/material.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class Signup extends StatelessWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return Material(
    //   child: Column(
    //     children: [
    //       BackButton(
    //         color: Colors.black,
    //         onPressed: () {
    //           Navigator.pop(context);
    //         },
    //       ),
    //       const Text("Back from signup")
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        title: const Text("SignUp"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              child: Image.asset("assets/images/signup.png"),
              width: 200,
              height: 180,
            ),
            Container(
              margin: const EdgeInsets.only(top: 30.0),
              child: TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Name"),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter Email"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter Password"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Enter Phone Number"),
            ),
            const SizedBox(
              height: 10.0,
            ),
            TextFormField(
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: "Enter Address"),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              child: Text(
                "Home Page",
                style: TextStyle(
                    color: MyThemes.creamColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
              style: TextButton.styleFrom(
                  minimumSize: const Size(250, 40),
                  backgroundColor: context.theme.buttonColor),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
