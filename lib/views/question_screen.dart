import 'package:flutter/material.dart';
import '../game_provider.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Answers'),
      ),
      //backgroundColor: Theme.of(context).primaryColor,
      body: _buildListAnswers(),
      floatingActionButton: _buildAddAnswerButton(),
    );
  }

  Widget _buildAddAnswerButton() {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        final controller = GameProvider.of(context);
        controller.addNewAnswer(task);
        setState(() {});
      },
    );
  }

  Widget _buildListAnswers() {
    return ListView.builder(
      itemCount: task.answers.length,
      itemBuilder: (context, index) => _buildAnswerTile(task.answers[index], index),
    );
  }

  Widget _buildAnswerTile(Answer answer, index) {
    return Dismissible(
        key: ValueKey(answer),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          final controller = GameProvider.of(context);
          controller.deleteAnswer(task, answer);
          setState(() {});
        },
        child: ListTile(
          trailing: Checkbox(
            value: answer.correctness,
            onChanged: (selected) {
              setState(() {
                answer.correctness = selected!;
              });
            },
          ),
          title: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.white,
              labelText: 'Answer #${index + 1}',
            ),
            initialValue: answer.answerText,
            onFieldSubmitted: (text) {
              setState(() {
                answer.answerText = text;
              });
            },
          ),
        ));
  }
}
