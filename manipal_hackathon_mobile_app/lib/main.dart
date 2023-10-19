import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/pages/homepage.dart';

void main() {
  runApp(const MindFulAIApp());
}

class MindFulAIApp extends StatelessWidget {
  const MindFulAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreenPage(),
    );
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  Future<Widget> futureCall() async {
    return Future.value(const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(logo: 
      const Image(image: AssetImage('assets/Logo.png'),),
      title: const Text(
        "Mindful AI",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      showLoader: true,
      loadingText: const Text("Loading..."),
    );
  }
}