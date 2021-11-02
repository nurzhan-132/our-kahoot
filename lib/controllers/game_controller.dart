import '../services/game_services.dart';
import '../models/data_layer.dart';

class GameController {
  final services = GameServices();

  List<Game> get games => List.unmodifiable(services.getAllGames());

  void addNewGame(String name) {
    if (name.isEmpty) {
      return;
    }

    name = _checkForDuplicates(games.map((game) => game.name), name);
    services.createGame(name);
  }

  void deleteGame(Game game) {
    services.delete(game);
  }

  void saveGame(Game game) {
    services.saveGame(game);
  }

  void addNewTask(Game game, String questionText) {
    if (questionText.isEmpty) {
      return;
    }

    questionText = _checkForDuplicates(game.tasks.map((task) => task.questionText), questionText);
    services.createTask(game, questionText);
  }

  void deleteTask(Game game, Task task) {
    services.deleteTask(game, task);
  }
  
  String _checkForDuplicates(Iterable<String> items, String text) {
    final duplicatedCount = items.where((item) => item.contains(text)).length;

    if (duplicatedCount > 0) {
      text += ' ${duplicatedCount + 1}';
    }

    return text;
  }
 
  // void addNewAnswer(Game game, Task task, [String? answerText]) {
    // Task _task = game.tasks.where((task_) => task_ == task).single;
    // _task.answers.add();

  //   if (answerText == null || answerText.isEmpty) {
  //     answerText = '';
  //   }

  //   description = _checkForDuplicates(
  //       plan.tasks.map((task) => task.description), description);
  //   services.addTask(plan, description);
  // }

  // void deleteAnswer(Game game, Task task, Answer answer) {

  // }

  void addNewAnswer(Game game, Task task, [String? answerText]) {
    if (answerText == null || answerText.isEmpty) {
      answerText = '';
    }

    //Task _task = game.tasks.where((task_) => task_ == task).single;
    //_task.answers.add();

    //answerText = _checkForDuplicates(_task.answers.map((answer) => answer.answerText), answerText);
    services.createAnswer(game, task, answerText);
  }

  void deleteAnswer(Game game, Task task, Answer answer) {
    services.deleteAnswer(game, task, answer);
  }
}
