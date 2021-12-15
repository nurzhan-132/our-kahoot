// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import '/views/creator/game_creator_screen.dart';
import '/models/all_models.dart';
import '/controllers/all_controllers.dart';
import './question_screen.dart';
import 'package:uuid/uuid.dart';

class QuestionCreatorScreen extends StatefulWidget {
  const QuestionCreatorScreen({Key? key}) : super(key: key);

  @override
  _QuestionCreatorScreenState createState() => _QuestionCreatorScreenState();
}

class _QuestionCreatorScreenState extends State<QuestionCreatorScreen> {
  Game get game => GameController.getGame(GameController.getCurrGame());
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const GameCreatorScreen())),
        ),
        title: const Text('Questions'),
      ),
      backgroundColor: Colors.deepPurpleAccent,
      body: Column(
        children: [_buildListCreator(), Expanded(child: _buildTask())],
      ),
    );
  }

  Widget _buildListCreator() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Material(
        color: Theme.of(context).cardColor,
        elevation: 10,
        child: TextField(
          controller: textController,
          decoration: const InputDecoration(
              prefixIcon: Icon(
                Icons.add_box_rounded,
                color: Colors.black,
                size: 30,
              ),
              labelText: 'Add a task',
              contentPadding: EdgeInsets.all(20)),
          onEditingComplete: addTask,
        ),
      ),
    );
  }

  void addTask() {
    final text = textController.text;

    final id = Uuid().v4();
    Task task = Task(id: id, questionText: text);
    GameController.addTask(task);

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildTask() {
    final tasks = game.tasks;

    if (tasks.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note,
            size: 100,
            color: Colors.yellow,
          ),
          Text(
            'You do not have any tasks yet.',
            style: Theme.of(context).textTheme.headline5,
          )
        ],
      );
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
            key: ValueKey(task),
            background: Container(color: Colors.red),
            direction: DismissDirection.endToStart,
            onDismissed: (_) {
              game.tasks.remove(task);
              GameController.deleteTask(task.id);
              setState(() {});
            },
            child: ListTile(
              title: Text(task.questionText),
              subtitle: Text(task.numberOfAnswersMessage()),
              onTap: () {
                GameController.getTask(task.id);
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const QuestionScreen()));
              },
            ));
      },
    );
  }
}
