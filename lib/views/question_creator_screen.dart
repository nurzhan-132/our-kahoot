import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class QuestionCreatorScreen extends StatefulWidget {
  static const route = '/question_creator_screen';
  const QuestionCreatorScreen({Key? key}) : super(key: key);

  @override
  _QuestionCreatorScreenState createState() => _QuestionCreatorScreenState();
}

class _QuestionCreatorScreenState extends State<QuestionCreatorScreen> {
  Task task = Task();

  @override
  Widget build(BuildContext context) {
    task = ModalRoute.of(context)!.settings.arguments as Task;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Answers'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildListAnswers(),
      floatingActionButton: _buildAddAnswerButton(),
    );
  }

  Widget _buildAddAnswerButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        setState(() {
          task.answers.add(Answer());
        });
      },
    );
  }

  Widget _buildListAnswers() {
    return ListView.builder(
      itemCount: task.answers.length,
      itemBuilder: (context, index) => _buildAnswerTile(task.answers[index]),
    );
  }

  Widget _buildAnswerTile(Answer answer) {
    return ListTile(
      title: TextField(
        onChanged: (text) {
          setState(() {
            answer.answerText = text;
          });
        },
      ),
    );
  }
}
