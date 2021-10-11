import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_testing_proj/widgets/themes.dart';
import 'package:velocity_x/velocity_x.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String name = "";
  bool changeBtn = false;
  final _formKey = GlobalKey<FormState>();

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
    //       const Text("Back from login")
    //     ],
    //   ),
    // );

    return Scaffold(
      backgroundColor: context.canvasColor,
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(14.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Text(
                "Welcome to Sign In $name",
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 20.0),
                child: Image.asset("assets/images/signin.png"),
                height: 250,
                width: 300,
              ),
              Container(
                margin: const EdgeInsets.only(top: 30.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Enter Email"),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter email address";
                    }

                    return null;
                  },
                  onChanged: (value) {
                    name = value;
                    setState(() {});
                  },
                ),
              ),
              const SizedBox(
                height: 10.0,
              ),
              TextFormField(
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Enter Password"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter password";
                  } else if (value.length < 6) {
                    return "Password length should be at least 6";
                  }

                  return null;
                },
              ),
              const SizedBox(
                height: 30.0,
              ),
              Material(
                color: context.theme.buttonColor,
                borderRadius: BorderRadius.circular(changeBtn ? 50 : 6),
                // shape: changeBtn ? BoxShape.circle : BoxShape.rectangle
                child: InkWell(
                  onTap: () => moveToHome(context),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    height: 40,
                    width: changeBtn ? 50 : 250,
                    alignment: Alignment.center,
                    child: changeBtn
                        ? const Icon(
                            Icons.done,
                            color: Colors.white,
                          )
                        : const Text(
                            "Home Page",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
              )

              // ElevatedButton(
              //   child: Text("Go to Home Page"),
              //   style: TextButton.styleFrom(minimumSize: const Size(250, 40)),
              //   onPressed: () {
              //     print("ysfsuf");
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeBtn = true;
      });
      await Future.delayed(Duration(seconds: 1));
      await Navigator.pushNamed(context, "/home");
      setState(() {
        changeBtn = false;
      });
    }
  }
}
