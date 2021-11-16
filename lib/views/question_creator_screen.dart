import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import './question_screen.dart';
import '../models/data_layer.dart';
import 'package:uuid/uuid.dart';

class QuestionCreatorScreen extends StatefulWidget {
  //static const route = '/question_creator_screen';

  final String? idGame;
  const QuestionCreatorScreen({Key? key, this.idGame}) : super(key: key);

  @override
  _QuestionCreatorScreenState createState() => _QuestionCreatorScreenState();
}

class _QuestionCreatorScreenState extends State<QuestionCreatorScreen> {
  Game get game => GameController.getGame(widget.idGame);
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              prefixIcon : Icon(
                Icons.add_box_rounded,
                color: Colors.black,
                size: 30,),
              labelText: 'Add a task', contentPadding: EdgeInsets.all(20)),
          onEditingComplete: addTask,
        ),
      ),
    );
  }

  void addTask() {
    final text = textController.text;

    final id = Uuid().v4();
    Task task = new Task(id: id, questionText: text);
    GameController.addTasks(game.id, task);


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
              //game.tasks.remove(task);
              GameController.deleteTask(game.id, task);
              setState(() {});
            },
            child: ListTile(
              title: Text(task.questionText),
              subtitle: Text(task.numberOfAnswersMessage()),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => QuestionScreen(idGame: game.id, idTask: task.id)));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => TaskProvider(child: MaterialApp(home: QuestionScreen(task: task)))));
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (_) => TaskProvider(
                //             child: const MaterialApp(
                //           home: QuestionScreen(task: task,),
                //         ))));
              },
            ));
      },
    );
  }
}