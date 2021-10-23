import 'package:flutter/material.dart';
import 'package:our_kahoot/views/question_creator_screen.dart';
import '../models/data_layer.dart';

class GameCreatorScreen extends StatefulWidget {
  static const route = '/game_creator_screen';
  const GameCreatorScreen({Key? key}) : super(key: key);

  @override
  _GameCreatorScreenState createState() => _GameCreatorScreenState();
}

class _GameCreatorScreenState extends State<GameCreatorScreen> {
  final game = Game();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
      backgroundColor: Theme.of(context).primaryColor,
      body: _buildListTasks(),
      floatingActionButton: _buildAddQuestionButton(),
    );
  }

  Widget _buildAddQuestionButton() {
    return FloatingActionButton(
      child: Icon(Icons.add),
      onPressed: () {
        setState(() {
          game.tasks.add(Task());
        });
      },
    );
  }

  Widget _buildListTasks() {
    return ListView.builder(
      itemCount: game.tasks.length,
      itemBuilder: (context, index) => _buildTaskTile(game.tasks[index]),
    );
  }

  Widget _buildTaskTile(Task task) {
    return ListTile(
      trailing: BackButton(
        onPressed:  /*_getQuestionScreen(task)*/null,
      ),
      title: TextField(
        onChanged: (text) {
          setState(() {
            task.questionText = text;
          });
        },
      ),
    );
  }

  _getQuestionScreen(Task task) {
    Navigator.of(context).pushNamed(QuestionCreatorScreen.route, arguments: task);
  }
}
