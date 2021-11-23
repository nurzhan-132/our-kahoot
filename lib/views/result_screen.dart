// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../views/game_user_screen.dart';
import '../views/question_user_screen.dart';
import '../controllers/all_controllers.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    QuizController _quizController = Get.put(QuizController());
    return Scaffold(
      body: WillPopScope(
        onWillPop: null,
        child: Stack(
          fit: StackFit.expand,
          children: [
            InkWell(
              onTap: () {
                Get.delete<QuizController>();
                Get.delete<QuestionUserScreen>();
                Get.to(() => GameUserScreen(
                      idUser: UserController.currentUser,
                    ));
              },
              child: Column(
                children: [
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    "Score",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.yellow),
                  ),
                  const Spacer(),
                  Text(
                    "${_quizController.numOfCorrectAns * 10}/${_quizController.numOfTasks * 10}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.yellow),
                  ),
                  const Spacer(
                    flex: 3,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
