import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LogInSuccess extends StatefulWidget {
  const LogInSuccess({super.key});

  @override
  State<LogInSuccess> createState() => _LogInSuccessState();
}

class _LogInSuccessState extends State<LogInSuccess> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                'lottie/success.json',
                height: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
