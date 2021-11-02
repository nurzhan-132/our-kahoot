import './answer.dart';
import '../repositories/repository.dart';

class Task {
  late final int id;
  String questionText;
  List<Answer> answers = [];

  Task({
    required this.id, this.questionText = '',
  });

  String numberOfAnswersMessage() {
    if (answers.length == 1) {
      return 'There is ${answers.length} answer';
    }
    return 'There are ${answers.length} answers';
  }

  Task.fromModel(Model model)
      : id = model.id,
        questionText = model.data['questionText'] ?? '',
        answers = model.data['answers']
                ?.map<Answer>((answer) => Answer.fromModel(answer))
                ?.toList() ??
            <Answer>[];

  Model toModel() => Model(id: id, data: {
        'questionText': questionText,
        'answers': answers.map((answer) => answer.toModel()).toList()
      });
}
