import 'package:flutter/material.dart';
import '../models/data_layer.dart';

class QuestionScreen extends StatefulWidget {
  //static const route = '/question_screen';
  final Task task;
  const QuestionScreen({Key? key, required this.task}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Task get task => widget.task;

  @override
  Widget build(BuildContext context) {
    //task = ModalRoute.of(context)!.settings.arguments as Task;

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
      child: const Icon(Icons.add),
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
      trailing: Checkbox(
        value: answer.correctness,
        onChanged: (selected) {
          setState(() {
            answer.correctness = selected!;
          });
        },
      ),
      title: TextFormField(
        initialValue: answer.answerText,
        onFieldSubmitted: (text) {
          setState(() {
            answer.answerText = text;
          });
        },
      ),
    );
  }
}
