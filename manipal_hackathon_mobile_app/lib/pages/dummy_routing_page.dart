import 'package:flutter/material.dart';
import 'package:manipal_hackathon_mobile_app/pages/home_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/login_page.dart';
import 'package:manipal_hackathon_mobile_app/pages/registration_page.dart';
import 'package:manipal_hackathon_mobile_app/utils/colours.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DummyRoutingPage extends StatefulWidget {
  const DummyRoutingPage({super.key});

  @override
  State<DummyRoutingPage> createState() => _DummyRoutingPageState();
}

class _DummyRoutingPageState extends State<DummyRoutingPage> {
  bool? justRegistered;

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      justRegistered = prefs.getBool("just_registered") ?? true;
    });
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  void refresh() {
    init();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: backgroundColour,
      body: justRegistered == null
          ? const Center(
              child: CircularProgressIndicator(
              color: greenColour,
            ))
          : justRegistered!
              ? RegPage(
                  onRegComplete: refresh,
                )
              : const HomePage(),
    ));
  }
}
