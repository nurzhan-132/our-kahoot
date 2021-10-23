import 'package:flutter/material.dart';
import './views/game_creator_screen.dart';
import 'game_provider.dart';

void main() => runApp(const OurKahoot());

class OurKahoot extends StatelessWidget {
  const OurKahoot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   routes: {
    //     '/': (context) => GameProvider(
    //           child: MaterialApp(home: GameCreatorScreen()),
    //         ),
    //     LoginScreen.route: (context) => const LoginScreen(),
    //     RegistrationScreen.route: (context) => const RegistrationScreen(),
    //     QuestionCreatorScreen.route: (context) => TaskProvider(child: MaterialApp(home: QuestionCreatorScreen(game: Game(),),)),
    //     QuestionScreen.route: (context) => QuestionScreen(task: Task()),

    //   },
    //   initialRoute: '/',
    // );
    return GameProvider(child: const MaterialApp(home: GameCreatorScreen()));
  }
}
