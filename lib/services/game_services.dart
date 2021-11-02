import '../repositories/in_memory_cache.dart';
import '../repositories/repository.dart';
import '../models/data_layer.dart';

class GameServices {
  final Repository _repository = InMemoryCache();

  Game createGame(String name) {
    final model = _repository.create();
    final game = Game.fromModel(model)..name = name;
    saveGame(game);
    return game;
  }

  void saveGame(Game game) {
    _repository.update(game.toModel());
  }

  void delete(Game game) {
    _repository.delete(game.toModel());
  }

  List<Game> getAllGames() {
    return _repository
        .getAll()
        .map<Game>((model) => Game.fromModel(model))
        .toList();
  }

  void createTask(Game game, String questionText) {
    int id = 0;
    if (game.tasks.isNotEmpty) {
      id = game.tasks.last.id + 1;
    }
    final task = Task(id: id, questionText: questionText);
    game.tasks.add(task);
    saveGame(game);
  }

  void deleteTask(Game game, Task task) {
    game.tasks.remove(task);
    saveGame(game);
  }

  void createAnswer(Game game, Task task, String answerText) {
    int id = 0;
    if (task.answers.isNotEmpty) {
      id = task.answers.last.id + 1;
    }
    final answer = Answer(id: id, answerText: answerText);
    task.answers.add(answer);
    saveGame(game);
  }

  void deleteAnswer(Game game, Task task, Answer answer) {
    Task _task = game.tasks.where((task_) => task_ == task).single;
    _task.answers.remove(answer);
    saveGame(game);
  }

}
