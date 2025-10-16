import 'package:astro_app/authentication/signup_screen.dart';
import 'package:flutter/material.dart';
import 'Screens/home_screen.dart';
import 'authentication/signin_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vastu Abhishek',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      initialRoute: '/home',
      routes: {
        '/signin': (context) => const SignInScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const VastuHomeScreen(),
      },
    );
  }
}