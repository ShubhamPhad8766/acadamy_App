// ignore_for_file: non_constant_identifier_names, use_build_context_synchronously

import 'package:academy_app/screens/forgot_password.dart';
import 'package:academy_app/screens/login_success.dart';
import 'package:academy_app/screens/sign_up_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '';
  String password = '';
  bool isPasswordVisible = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LogInSuccess(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "No User Found For That email",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Wrong Password Provide By User",
            style: TextStyle(color: Colors.black, fontSize: 18.0),
          ),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: const Text(
            "FLUTTER ACADEMY",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.black,
        ),
        backgroundColor: CupertinoColors.white,
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _headerWidget(context),
                _loginWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _headerWidget(BuildContext context) {
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

  _loginWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        const Text(
          "Welcome back, login to your account",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        const SizedBox(
          height: 10.0,
        ),
        TextFormField(
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'please Enter E-Mail';
            }
            return null;
          },
          decoration: const InputDecoration(
              hintText: 'Enter your Email',
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
              return 'please Enter Password';
            }
            return null;
          },
          obscureText: !isPasswordVisible,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                ),
              ),
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
                  ),
                );
              },
              child: const Text(
                "Forgot Password?",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                if (_formKey.currentState!.validate()) {
                  email = emailController.text;
                  password = passwordController.text;
                }
                userLogin();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                fixedSize: const Size(1000.0, 60.0),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white),
              )),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("New User? ", style: TextStyle(color: Colors.grey)),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
                );
              },
              child: const Text("Create Account ",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ],
    );
  }
}
