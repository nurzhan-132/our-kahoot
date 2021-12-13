// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/user.dart';
import '/views/user/game_user_screen.dart';
import 'quiestion_user_screen/question_user_screen.dart';
import '/controllers/all_controllers.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController _quizController = Get.put(QuizController());
    UserController.setResultToUser(
        GameController.getCurrGameId(), _quizController.numOfCorrectAns);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.delete<QuizController>();
          Get.delete<QuestionUserScreen>();
          Get.to(() => GameUserScreen(
                idUser: UserController.currentUser,
              ));
          return false;
        },
        child: Column(
          children: [Expanded(child: _buildListPlayers())],
        ),
      ),
    );
  }

  Widget _buildListPlayers() {
    List<User> users = UserController.getUsers();
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        final indexCurrGame = GameController.getCurrGameIndex(user);

        if (indexCurrGame != -1) {
          return ListTile(
            title: Text('${user.name} - ${user.games[indexCurrGame].result}'),
            onTap: () {
              Get.delete<QuizController>();
              Get.delete<QuestionUserScreen>();
              Get.to(() => GameUserScreen(
                    idUser: UserController.currentUser,
                  ));
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
