import 'package:academy_app/screens/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBbHFwU6shZJZfjeBUjJXAa9nM__z-jiOc",
          authDomain: "academy-app-55345.firebaseapp.com",
          projectId: "academy-app-55345",
          storageBucket: "academy-app-55345.appspot.com",
          messagingSenderId: "583377693743",
          appId: "1:583377693743:web:588d2d25a23c6a92e5aada",
          measurementId: "G-Z9ZR379LGW")
      // options: DefaultFirebaseOptions.currentPlatform
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // initialRoute: '/login-screen',
      // routes: {
      //   '/home': (context) => const HomeScreen(),
      //   'login-screen': (context) => const LoginScreen(),
      //   'sign-up-screen': (context) => const SignUpScreen(),
      //   'forgot-password-screen': (context) => const ForgotPasswod(),
      // },
      home: SignUpScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
