// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import './question_creator_screen.dart';
import 'package:uuid/uuid.dart';
import '/controllers/all_controllers.dart';
import '/models/all_models.dart';
import '../menu/login_screen/login_screen.dart';

class GameCreatorScreen extends StatefulWidget {
  const GameCreatorScreen({Key? key}) : super(key: key);

  @override
  _GameCreatorScreenState createState() => _GameCreatorScreenState();
}

class _GameCreatorScreenState extends State<GameCreatorScreen> {
  final textController = TextEditingController();
  late List<Game> games;
  late User user;

  @override
  void initState() {
    super.initState();

    user = UserController.getUser(UserController.getCurrentUser());
    games = GameController.getUserGames(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Games'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen())),
        ),
      ),
      body: Column(
        children: [_buildListCreator(), Expanded(child: _buildGame())],
      ),
    );
  }

  Widget _buildListCreator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
              labelText: 'Add a game', contentPadding: EdgeInsets.all(20)),
          onEditingComplete: addGame,
        ),
      ),
    );
  }

  void addGame() async {
    final text = textController.text;

    final id = Uuid().v4();
    Game game = Game(id: id, name: text);
    GameController.addGame(game);

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildGame() {
    games = GameController.getUserGames(user);
    if (games.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
          ),
          Text(
            'You do not have any games yet.',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: games.length,
      itemBuilder: (context, index) {
        final game = games[index];
        return Dismissible(
            key: ValueKey(game),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              GameController.deleteGame(game.id);
              setState(() {});
            },
            child: ListTile(
              title: Text(game.name),
              subtitle: Text(game.numberOfTasksMessage()),
              onTap: () {
                GameController.setCurrGame(game.id);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const QuestionCreatorScreen()));
              },
            ));
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }
}
