import './answer.dart';

class Task {
  //final int id;
  String questionText;
  List<Answer> answers = [];

  Task({
    /* required this.id ,*/ this.questionText = '',
  });

  String numberOfAnswersMessage() {
    if (answers.length == 1) {
      return 'There is ${answers.length} answer';
    }
    return 'There are ${answers.length} answers';
  }
}
