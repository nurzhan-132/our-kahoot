import 'package:flutter/material.dart';
import 'views/login_screen.dart';
import './views/game_creator_screen.dart';
import 'views/registration_screen.dart';

void main() => runApp(const OurKahoot());

class OurKahoot extends StatelessWidget {
  const OurKahoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const LoginScreen(),
        RegistrationScreen.route: (context) => const RegistrationScreen(),
        GameCreatorScreen.route: (context) => const GameCreatorScreen(),
        LoginScreen.route: (context) => const LoginScreen(),
      },
      initialRoute: '/',
    );
    //return GameProvider(child: const MaterialApp(home: GameCreatorScreen()));
  }
}
