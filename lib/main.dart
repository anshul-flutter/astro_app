import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'authentication/login_screen.dart';
import 'authentication/signin_screen.dart';
import 'authentication/signup_screen.dart';
import 'authentication/start_screen.dart';

// ==================== MAIN.DART ====================
void main() async { // 2. Make the main function async
  // 3. Ensure Flutter bindings are initialized before using services
  WidgetsFlutterBinding.ensureInitialized();

  // 4. Set the default system UI overlay style for the app
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    // Make the status bar transparent
    statusBarColor: Colors.transparent,
    // Use dark icons for the status bar (time, battery, etc.)
    // This is suitable for light-colored backgrounds.
    statusBarIconBrightness: Brightness.dark,
  ));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Astrology App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        fontFamily: 'SF Pro',
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/login': (context) => const LoginScreen(),
        '/signin': (context) => const SignInScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}