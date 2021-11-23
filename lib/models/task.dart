import './answer.dart';

class Task {
  late final String id;
  String questionText;
  List<Answer> answers;

  Task({required this.id, this.questionText = '', this.answers = const []});

  String numberOfAnswersMessage() {
    if (answers.length == 1) {
      return 'There is ${answers.length} answer';
    }
    return 'There are ${answers.length} answers';
  }

  Task copy({
    String? id,
    String? questionText,
    List<Answer>? answers,
  }) =>
      Task(
        id: id ?? this.id,
        questionText: questionText ?? this.questionText,
        answers: answers ?? this.answers,
      );

  static Task fromJson(Map<String, dynamic> json) => Task(
        id: json['id'],
        questionText: json['questionText'],
        answers: json['answers']
                ?.map<Answer>((answer) => Answer.fromJson(answer))
                ?.toList() ??
            <Answer>[],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'questionText': questionText,
        'answers': answers.map((answer) => answer.toJson()).toList(),
      };

  @override
  String toString() => 'Task{id: $id, questionText: $questionText}';
}
