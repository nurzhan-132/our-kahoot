import 'package:flutter/material.dart';
import '../models/game.dart';
import '../controllers/game_controller.dart';
import './question_creator_screen.dart';
import 'package:uuid/uuid.dart';

class GameCreatorScreen extends StatefulWidget {
  static const route = '/game_creator_screen';
  const GameCreatorScreen({Key? key}) : super(key: key);

  @override
  _GameCreatorScreenState createState() => _GameCreatorScreenState();
}

class _GameCreatorScreenState extends State<GameCreatorScreen> {
  final textController = TextEditingController();
  late List<Game> games;

  @override
  void initState() {
    super.initState();

    games = GameController.getGames();
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

  void addGame() async{
    final text = textController.text;

    final id = Uuid().v4();
    Game game = new Game(id: id, name: text);
    await GameController.addGames(game);
    games = GameController.getGames();

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildGame() {
    //final games = GameProvider.of(context).games;

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
                //Navigator.of(context).pushNamed(QuestionCreatorScreen.route, arguments: game);
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => GameProvider(child: MaterialApp(home: QuestionCreatorScreen(game: game)))));
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => QuestionCreatorScreen(idGame: game.id)));
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
