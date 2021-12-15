// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/views/user/game_user_screen.dart';
import 'quiestion_user_screen/question_user_screen.dart';
import '/controllers/all_controllers.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController _quizController = Get.put(QuizController());
    UserController.setResultToUser(
        GameController.getCurrGame(), _quizController.numOfCorrectAns);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Get.delete<QuizController>();
          Get.delete<QuestionUserScreen>();
          Get.to(() => const GameUserScreen());
          return false;
        },
        child: Column(
          children: [Expanded(child: _buildListPlayers())],
        ),
      ),
    );
  }

  Widget _buildListPlayers() {
    Map<String, int> results = UserController.getAllGameResults();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        String resKey = results.keys.elementAt(index);
        return ListTile(
          title: Text('$resKey - ${results[resKey]}'),
          onTap: () {
            Get.delete<QuizController>();
            Get.delete<QuestionUserScreen>();
            Get.to(() => const GameUserScreen());
          },
        );
      },
    );
  }
}
