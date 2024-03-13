// ignore_for_file: non_constant_identifier_names, use_super_parameters, use_build_context_synchronously

import 'package:academy_app/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswod extends StatefulWidget {
  const ForgotPasswod({Key? key}) : super(key: key);

  @override
  State<ForgotPasswod> createState() => _ForgotPasswodState();
}

class _ForgotPasswodState extends State<ForgotPasswod> {
  String email = '';
  final _forkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
        "Password Reset Email has been Sent",
        style: TextStyle(color: Colors.black, fontSize: 18.0),
      )));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
          "No User Found that Email",
          style: TextStyle(color: Colors.black, fontSize: 18.0),
        )));
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
          child: Column(
            children: [
              _hederwidget(context),
              _Loginwidget(context),
            ],
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
                "academy",
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
      key: _forkey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Forgot \nPassword",
            style: TextStyle(
                fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const Text(
            "Don't worry! We've got your back",
            style: TextStyle(
                fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey),
          ),
          const SizedBox(
            height: 10.0,
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
            height: 20.0,
          ),
          const Text(
            "Note- An Email will be sent to your Email. Please check your Email to reset your password.",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 10.0,
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Center(
            child: ElevatedButton(
                onPressed: () {
                  if (_forkey.currentState!.validate()) {
                    email = emailController.text;
                  }
                  resetPassword();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  fixedSize: const Size(1000.0, 60.0),
                ),
                child: const Text(
                  "Send Email",
                  style: TextStyle(color: Colors.white),
                )),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Already a user? ",
                  style: TextStyle(color: Colors.grey)),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
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
