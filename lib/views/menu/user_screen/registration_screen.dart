import 'package:flutter/material.dart';
import 'widgets/registration_body_widget.dart';

class RegistrationScreen extends StatefulWidget {
  final String? idUser;

  const RegistrationScreen({
    Key? key,
    this.idUser,
  }) : super(key: key);

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: RegistrationBodyWidget(),
    );
  }
}
