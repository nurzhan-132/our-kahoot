import '../repositories/repository.dart';

class Answer {
  final int id;
  String answerText;
  bool correctness;

  Answer({required this.id, this.answerText = '', this.correctness = false});

  Answer.fromModel(Model model)
      : id = model.id,
        answerText = model.data['answerText'] ?? '',
        correctness = model.data['correctness'] ?? false;

  Model toModel() => Model(
      id: id, data: {'answerText': answerText, 'correctness': correctness});
}
