// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/models/all_models.dart';
import '/controllers/all_controllers.dart';
import 'widgets/body_widget.dart';

class QuestionUserScreen extends StatefulWidget {
  final String? idGame;
  const QuestionUserScreen({Key? key, this.idGame}) : super(key: key);

  @override
  _QuestionUserScreenState createState() => _QuestionUserScreenState();
}

class _QuestionUserScreenState extends State<QuestionUserScreen> {
  Game get game => GameController.getGame(widget.idGame);
  late List<Task> tasks;
  late QuizController quizController;

  @override
  void initState() {
    super.initState();
    tasks = GameController.getTasks(game.id);
    quizController = Get.put(QuizController());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.delete<QuizController>();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurpleAccent,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          actions: [
            // ignore: deprecated_member_use
            FlatButton(
                onPressed: quizController.nextTask, child: const Text("Skip"))
          ],
        ),
        body: BodyWidget(tasks: tasks),
      ),
    );
  }
}
