import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/game.dart';
import '../controllers/game_controller.dart';
import 'package:uuid/uuid.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';
import 'question_user_screen.dart';

class GameUserScreen extends StatefulWidget {
  static const route = '/game_creator_screen';
  final String? idUser;

  const GameUserScreen({Key? key, this.idUser}) : super(key: key);

  @override
  _GameUserScreenState createState() => _GameUserScreenState();
}

class _GameUserScreenState extends State<GameUserScreen> {
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
        children: [Expanded(child: _buildGame())],
      ),
    );
  }

  Widget _buildGame() {

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
        return Container(
            key: ValueKey(game),
            child: ListTile(
              title: Text(game.name),
              subtitle: Text(game.numberOfTasksMessage()),
              onTap: () {
                Get.to(() => QuestionUserScreen(idGame: game.id,));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => QuestionUserScreen(idGame: game.id,)));
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
