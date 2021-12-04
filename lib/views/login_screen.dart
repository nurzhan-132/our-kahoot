import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widgets/login_body_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: LoginBodyWidget(),
    );
  }

}


