import 'package:flutter/material.dart';
import '../controllers/game_controller.dart';
import '../models/data_layer.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class QuestionScreen extends StatefulWidget {
  //static const route = '/question_screen';
  final String? idGame;
  final String? idTask;
  
  const QuestionScreen({Key? key, this.idGame, this.idTask}) : super(key: key);

  @override
  _QuestionScreenState createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  Game get game => GameController.getGame(widget.idGame);
  Task get task => GameController.getTask(widget.idGame, widget.idTask);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Answers',textAlign: TextAlign.center, style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.amberAccent,
        ),),
        backgroundColor: CupertinoColors.tertiaryLabel,
      ),
      //backgroundColor: Theme.of(context).primaryColor,
      body: _buildListAnswers(),
      floatingActionButton: _buildAddAnswerButton(),
    );
  }

  Widget _buildAddAnswerButton()  {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () async{
        final id = Uuid().v4();
        Answer answer = new Answer(id: id);
        await GameController.addAnswer(game.id, task.id, answer);
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
    //print('$index Answers');
    return Dismissible(
        key: ValueKey(answer),
        background: Container(color: Colors.red),
        direction: DismissDirection.endToStart,
        onDismissed: (_) {
          //task.answers.remove(answer);
          //GamePreferences.deleteAnswer(game.id, task, answer);
          //setState(() {});
        },
        child: ListTile(
          trailing: Checkbox(
            value: answer.correctness,
            onChanged: (selected) {
              setState(() {
                answer.correctness = selected!;
              });
              GameController.setAnswerCorrectness(game.id, task.id, answer.id, answer.correctness);
            },
          ),
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
        )
        );
  }
}
