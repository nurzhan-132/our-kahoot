// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import '/views/creator/question_creator_screen.dart';
import '/models/all_models.dart';
import '/controllers/game_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Task get task => GameController.getTask(GameController.getCurrTask());
  int selectedValue = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const QuestionCreatorScreen())),
        ),
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
      floatingActionButton:
          _showAddAnswerButton() ? _buildAddAnswerButton() : null,
    );
  }

  bool _showAddAnswerButton() {
    if (task.answers.length >= 4) {
      return false;
    } else {
      return true;
    }
  }

  Widget _buildAddAnswerButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async {
        final id = Uuid().v4();
        Answer answer = Answer(id: id);
        GameController.addAnswer(answer);
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
        GameController.deleteAnswer(answer.id);
        setState(() {});
      },
      child: RadioListTile(
        value: index as int,
        groupValue: selectedValue,
        onChanged: (value) => setState(() {
          selectedValue = value as int;
          for (var i = 0; i < task.answers.length; i++) {
            GameController.setAnswerCorrectness(task.answers[i].id, false);
          }
          GameController.setAnswerCorrectness(
              task.answers[selectedValue].id, true);
        }),
        title: TextFormField(
          decoration: InputDecoration(
            fillColor: Colors.white,
            labelText: 'Answer #${index + 1}',
          ),
          initialValue: answer.answerText,
          onFieldSubmitted: (text) {
            GameController.setAnswerText(answer.id, text);
          },
        ),
      ),
    );
  }
}
