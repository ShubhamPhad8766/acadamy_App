// ignore_for_file: non_constant_identifier_names, unused_local_variable, deprecated_member_use, use_build_context_synchronously

import 'package:academy_app/home.dart';
import 'package:academy_app/screens/forgot_password.dart';
import 'package:academy_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name = '', email = '', password = '';
  bool ispasswordvisible = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  registration() async {
    try {
      List<String> signInMethods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);

      if (signInMethods.contains('password')) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account already exists. Please login.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.greenAccent,
            content: Text(
              "Registered Successfully",
              style: TextStyle(fontSize: 20.0),
            ),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Provided is too Weak",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Account Already Exists. Please login.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "FLUTTER ACADEMY",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                _hederwidget(context),
                _Loginwidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _hederwidget(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 50.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: 70.0,
            width: 5.0,
            color: Colors.black,
          ),
          const SizedBox(
            width: 10.0,
          ),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2 ByteCode's",
                style: TextStyle(fontSize: 10.0, color: Colors.grey),
              ),
              Text(
                "FLUTTER",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              Text(
                "accademy",
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  _Loginwidget(BuildContext context) {
    return Form(
      key: _formkey, 
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "SIGN UP",
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            "Hey Enter your details and create an account",
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: nameController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Enter Your Name';
              }
              return null;
            },
            decoration: const InputDecoration(
                hintText: 'Enter your full name',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: emailController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Email';
              }
              return null;
            },
            decoration: const InputDecoration(
                hintText: 'Enter an email address',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please Enter Password';
              }
              return null;
            },
            obscureText: !ispasswordvisible,
            decoration: InputDecoration(
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        ispasswordvisible = !ispasswordvisible;
                      });
                    },
                    icon: Icon(ispasswordvisible
                        ? Icons.visibility
                        : Icons.visibility_off)),
                hintText: 'Enter your Password',
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ForgotPasswod(),
                      ));
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10.0,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (_formkey.currentState!.validate()) {}
                  setState(() {
                    name = nameController.text;
                    email = emailController.text;
                    password = passwordController.text;
                  });

                  registration();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(1000, 60),
                ),
                child: const Text(
                  "SIGN UP",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Alredy a user? ",
                  style: TextStyle(color: Colors.grey)),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                },
                child: const Text("Login Here ",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
