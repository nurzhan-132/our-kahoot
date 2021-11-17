import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:our_kahoot/controllers/game_controller.dart';
import 'package:our_kahoot/controllers/user_controller.dart';
import 'package:our_kahoot/views/game_user_screen.dart';
import '../controllers/quiz_controller.dart';

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
                Get.to(() => GameUserScreen(idUser: UserController.currentUser,));
              },
              child: Column(
                children: [
                  Spacer(flex: 3,),
                  Text(
                    "Score",
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Colors.yellow),
                  ),
                  Spacer(),
                  Text(
                    "${_quizController.numOfCorrectAns * 10}/${_quizController.numOfTasks * 10}",
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(color: Colors.yellow),
                  ),
                  Spacer(flex: 3,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
