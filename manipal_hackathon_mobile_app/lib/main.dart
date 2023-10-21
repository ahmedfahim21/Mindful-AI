import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/pages/dummy_routing_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/home_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/login_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/registration_page.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MindFulAIApp());
}

class MindFulAIApp extends StatelessWidget {
  const MindFulAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'MindFul AI',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: backgroundColour.withOpacity(0.6)),
          useMaterial3: true,
        ),
        home: const SplashScreenPage());
  }
}

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
        logo: const Image(
          image: AssetImage('assets/Logo.png'),
        ),
        backgroundColor: backgroundColour,
        title: const Text(
          "Mindful AI",
          style: TextStyle(
              fontSize: 22, fontWeight: FontWeight.w700, letterSpacing: 0.7),
        ),
        showLoader: true,
        loadingText: const Text(
          "Loading...",
          style: TextStyle(
              fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.7),
        ),
        loadingTextPadding: const EdgeInsets.all(8),
        loaderColor: greenColour,
        durationInSeconds: 2,
        navigator: const DummyWidget());
  }
}

class DummyWidget extends StatelessWidget {
  const DummyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
              return const DummyRoutingPage();
          } else if (snapshot.hasError) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("There was an error in logging you in!")));
            return const LoginPage();
          } else {
            return const LoginPage();
          }
        });
  }
}
