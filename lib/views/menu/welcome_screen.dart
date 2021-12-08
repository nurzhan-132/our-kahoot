import 'package:flutter/material.dart';
import 'home_screen/home_screen.dart';
import '/animations/custom_page_route.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  void initState() {
    super.initState();
    _goHome();
  }

  _goHome() async {
    await Future.delayed(const Duration(seconds: 4));
    Navigator.of(context).pushReplacement(CustomPageRoute(child: const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: Text(
        'OUR-KAHOOT',
        style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
      ),
    ));
  }
}
