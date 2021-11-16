import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/quiz_controller.dart';
import '../controllers/game_controller.dart';
import './question_screen.dart';
import '../models/data_layer.dart';
import '../widgets/body_widget.dart';
import 'package:uuid/uuid.dart';

class QuestionUserScreen extends StatefulWidget {
  //static const route = '/question_creator_screen';

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
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [FlatButton(onPressed: quizController.nextTask, child: Text("Skip"))],
      ),
      body: BodyWidget(tasks: tasks),
    );
  }

}


