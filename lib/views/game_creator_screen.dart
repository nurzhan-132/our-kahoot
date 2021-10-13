import 'package:flutter/material.dart';

class GameCreatorScreen extends StatefulWidget {
  static const route = '/game_creator_screen';
  const GameCreatorScreen({Key? key}) : super(key: key);

  @override
  _GameCreatorScreenState createState() => _GameCreatorScreenState();
}

class _GameCreatorScreenState extends State<GameCreatorScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text('Here will be tasks', style: TextStyle(color: Colors.white)),
      ]),
    );
  }
}
