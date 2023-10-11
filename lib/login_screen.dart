import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup_firebase/home_page.dart';
import 'package:signup_firebase/user_resgistration.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _usernamenameController = TextEditingController();

  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LoginPage"),
        backgroundColor: Colors.lightBlue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock,
            size: 60,
          ),
          SizedBox(
            height: 10,
          ),
          Text("Login Page",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: TextField(
                controller: _usernamenameController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    hintText: "Username or Email address"),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Center(
              child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  hintText: "Password"),
              textAlign: TextAlign.center,
            ),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
                color: Colors.lightBlue,
                minWidth: double.infinity,
                onPressed: () {
                  checklogin(context);
                },
                child: Text("Login")),
          ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignUp(),
                  ));
            },
            child: Text("SignUp"),
          )
        ],
      ),
    );
  }

  void checklogin(BuildContext ctx) async {
    final username = _usernamenameController.text;
    final pswd = _passwordController.text;

    if (username.isNotEmpty && pswd.isNotEmpty) {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: pswd,
        );
        // If login is successful, navigate to the home page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      } catch (e) {
        String errorMessage = "An error occurred. Please try again.";

        if (e is FirebaseAuthException) {
          switch (e.code) {
            // case 'user-not-found':
            //   errorMessage = "No user found for this email.";
            //   break;
            case 'INVALID_LOGIN_CREDENTIALS':
              errorMessage = "USER NAME OR PASSWORD IS INVALID .";
              break;
            case 'wrong-password':
              errorMessage = "Wrong password provided for this user.";
              break;
            default:
              errorMessage = e.message ?? "Unknown error occurred.";
              break;
          }
        }

        // Show the error message to the user
        ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
          content: Text(
            errorMessage,
            style: TextStyle(color: Colors.red),
          ),
        ));
      }
    } else {
      ScaffoldMessenger.of(ctx).showSnackBar(SnackBar(
        content: Text(
          "Please enter username and password",
          style: TextStyle(color: Colors.red),
        ),
      ));
    }
  }
}
