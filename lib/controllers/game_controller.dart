import '../models/data_layer.dart';

class GameController {
  final _games = <Game>[];

  List<Game> get games => List.unmodifiable(_games);

  void addNewGame(String name) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(_games.map((game) => game.name), name);
    final game = Game()..name = name;
    _games.add(game);
  }

  void deleteGame(Game game) {
    _games.remove(game);
  }

  void addNewTask(Game game, String questionText) {
    if (questionText.isEmpty) {
      return;
    }

    questionText = _checkForDuplicates(
        game.tasks.map((task) => task.questionText), questionText);
    final task = Task()..questionText = questionText;
    game.tasks.add(task);
  }

  void deleteTask(Game game, Task task) {
    game.tasks.remove(task);
  }

  void addNewAnswer(Task task, [String? answerText]) {
    if (answerText == null || answerText.isEmpty) {
      answerText = '';
    }

    final answer = Answer()..answerText = answerText;
    task.answers.add(answer);
  }

  void deleteAnswer(Task task, Answer answer) {
    task.answers.remove(answer);
  }

  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount = items.where((item) => item.contains(text)).length;

    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }

    return text;
  }
}
