// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import './question_creator_screen.dart';
import 'package:uuid/uuid.dart';
import '../controllers/all_controllers.dart';
import '../models/all_models.dart';

class GameCreatorScreen extends StatefulWidget {
  final String? idUser;

  const GameCreatorScreen({Key? key, this.idUser}) : super(key: key);

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

    games = GameController.getGames();
    user = UserController.getUser(widget.idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Games'),
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
    await GameController.addGames(game);
    games = GameController.getGames();

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildGame() {
    games = GameController.getGames();
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
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => QuestionCreatorScreen(idGame: game.id)));
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
