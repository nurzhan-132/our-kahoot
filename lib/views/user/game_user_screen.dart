// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../menu/login_screen/login_screen.dart';
import 'quiestion_user_screen/question_user_screen.dart';
import '/models/all_models.dart';
import '/controllers/all_controllers.dart';

class GameUserScreen extends StatefulWidget {
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
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: const Text('Games'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginScreen())),
        ),
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
                Get.to(() => QuestionUserScreen(
                      idGame: game.id,
                    ));
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
