// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import '/models/all_models.dart';
import '/controllers/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class QuestionScreen extends StatefulWidget {
  final String? idGame;
  final String? idTask;

  const QuestionScreen({Key? key, this.idGame, this.idTask}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Game get game => GameController.getGame(widget.idGame);
  Task get task => GameController.getTask(widget.idGame, widget.idTask);
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Answers',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.amberAccent,
          ),
        ),
        backgroundColor: CupertinoColors.tertiaryLabel,
      ),
      body: _buildListAnswers(),
      floatingActionButton: _buildAddAnswerButton(),
    );
  }

  Widget _buildAddAnswerButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final id = Uuid().v4();
        Answer answer = Answer(id: id);
        await GameController.addAnswer(game.id, task.id, answer);
        setState(() {});
      },
    );
  }

  Widget _buildListAnswers() {
    return ListView.builder(
      itemCount: task.answers.length,
      itemBuilder: (context, index) =>
          _buildAnswerTile(task.answers[index], index),
    );
  }

  Widget _buildAnswerTile(Answer answer, index) {
    if (answer.correctness == true) {
      selectedValue = index;
    }
    return Dismissible(
      key: ValueKey(answer),
      background: Container(color: Colors.red),
      direction: DismissDirection.endToStart,
      onDismissed: (_) {
        //task.answers.remove(answer);
        //GamePreferences.deleteAnswer(game.id, task, answer);
        //setState(() {});
        GameController.deleteAnswer(game.id, task.id, answer.id);
      },
      child: RadioListTile(
        value: index as int,
        groupValue: selectedValue,
        onChanged: (value) => setState(() {
          selectedValue = value as int;
          for (var i = 0; i < task.answers.length; i++) {
            GameController.setAnswerCorrectness(
                game.id, task.id, task.answers[i].id, false);
          }
          GameController.setAnswerCorrectness(
              game.id, task.id, task.answers[selectedValue].id, true);
        }),
        title: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            labelText: 'Answer #${index + 1}',
          ),
          initialValue: answer.answerText,
          onFieldSubmitted: (text) {
            GameController.setAnswerText(game.id, task.id, answer.id, text);
          },
        ),
      ),
    );
  }
}
