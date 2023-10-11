import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:signup_firebase/home_page.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  // TextEditingController usernamecontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  void signup() async {
    //final username = usernamecontroller.text;
    final passwrd = passwordcontroller.text;
    final email = emailcontroller.text;
    if (passwrd.isNotEmpty && email.isNotEmpty) {
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: passwrd)
          .then(
            (value) => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomePage(),
              ),
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Full Name"),
                textAlign: TextAlign.center,
              ),
            ),
          ),

          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Email Address"),
              textAlign: TextAlign.center,
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Username"),
              textAlign: TextAlign.center,
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: passwordcontroller,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Password"),
              textAlign: TextAlign.center,
            ),
          )),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Confirm Password"),
              textAlign: TextAlign.center,
            ),
          )),
          ElevatedButton(
            onPressed: () async {
              signup();
            },
            child: Text("Submit"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Back"),
          )
          // ElevatedButton(
          //     onPressed: () {
          //       // Text("Logged in")
          //     },
          //     child: Text("Submit"))
        ],
      ),
    );
  }
}
