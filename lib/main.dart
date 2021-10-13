import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:our_kahoot/views/game_creator_screen.dart';
import 'package:our_kahoot/views/login_screen.dart';

import 'views/registration_screen.dart';

void main() => runApp(OurKahoot());

class OurKahoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
        GameCreatorScreen.route: (context) => const GameCreatorScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
      },
      initialRoute: '/',
    );
  }
}
