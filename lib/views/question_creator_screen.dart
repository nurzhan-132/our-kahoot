import 'package:flutter/material.dart';
import './question_screen.dart';
import '../models/data_layer.dart';

class QuestionCreatorScreen extends StatefulWidget {
  //static const route = '/question_creator_screen';
  final Game game;
  const QuestionCreatorScreen({Key? key, required this.game}) : super(key: key);

  @override
  _QuestionCreatorScreenState createState() => _QuestionCreatorScreenState();
}

class _QuestionCreatorScreenState extends State<QuestionCreatorScreen> {
  Game get game => widget.game;
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks'),
      ),
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
              labelText: 'Add a task', contentPadding: EdgeInsets.all(20)),
          onEditingComplete: addTask,
        ),
      ),
    );
  }

  void addTask() {
    final text = textController.text;

    if (text.isEmpty) {
      return;
    }

    final task = Task()..questionText = text;
    game.tasks.add(task);
    //TaskProvider.of(context).add(task);

    textController.clear();
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {});
  }

  Widget _buildTask() {
    //final tasks = TaskProvider.of(context);
    final tasks = game.tasks;

    if (tasks.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.note,
            size: 100,
            color: Colors.grey,
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
        return ListTile(
          title: Text(task.questionText),
          subtitle: Text(task.numberOfAnswersMessage()),
          onTap: () {
            //Navigator.of(context).pushNamed(QuestionScreen.route, arguments: task);
            Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => QuestionScreen(task: task)));
          },
        );
      },
    );
  }
}
