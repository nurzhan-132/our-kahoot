import './answer.dart';

class Task {
  //final int id;
  String questionText;
  List<Answer> answers = [];
  Answer? correctAnswer;

  Task({/* required this.id ,*/ this.questionText = '', this.correctAnswer});
}