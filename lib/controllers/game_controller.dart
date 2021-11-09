import 'dart:convert';
import '../models/game.dart';
import '../models/task.dart';
import '../models/answer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController {
  static late SharedPreferences _preferences;

  static const _keyGames = 'games';

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setGame(Game game) async {
    final json = jsonEncode(game.toJson());
    final idGame = game.id;

    await _preferences.setString(idGame, json);
  }

  static Future setAnswerText(String idGame, String idTask, String idAnswer, String answerText) async {
    Game game = getGame(idGame);
    Task task = game.tasks.firstWhere((element) => element.id == idTask);
    Answer answer = task.answers.firstWhere((element) => element.id == idAnswer);
    answer.answerText = answerText;
    setGame(game);
  }

  static Future setAnswerCorrectness(String idGame, String idTask, String idAnswer, bool correctness) async {
    Game game = getGame(idGame);
    Task task = game.tasks.firstWhere((element) => element.id == idTask);
    Answer answer = task.answers.firstWhere((element) => element.id == idAnswer);
    answer.correctness = correctness;
    setGame(game);
  }

  static Game getGame(String? idGame) {
    final json = _preferences.getString(idGame);

    return Game.fromJson(jsonDecode(json));
  }
  
  static Task getTask(String? idGame, String? idTask) {
    final json = _preferences.getString(idGame);
    Game game = Game.fromJson(jsonDecode(json));
    Task task = game.tasks.firstWhere((element) => element.id == idTask);
    return task;
  }

  static void deleteGame(String? idGame) {
    //_preferences.remove(idGame);
  }

  static void deleteTask(String? idGame, Task task) {
    // final json = _preferences.getString(idGame);
    // Game game = Game.fromJson(jsonDecode(json));
    // game.tasks.remove(task);
    // setGame(game);
  }

  static void deleteAnswer(String? idGame, Task task, Answer answer) {
    // final json = _preferences.getString(idGame);
    // Game game = Game.fromJson(jsonDecode(json));
    // task.answers.remove(answer);
    // setGame(game);
  }

  static void addTasks(String? idGame, Task task) async {
    Game game = getGame(idGame);
    game.tasks.add(task);
    setGame(game);
  }

  static Future addAnswer(String? idGame, String? taskId, Answer answer) async {
    Game game = getGame(idGame);
    Task ntask = game.tasks.firstWhere((element) => element.id == taskId);
    ntask.answers.add(answer);
    setGame(game);
    print("WTFFFF?????");
  }

  static Future addGames(Game game) async {
    final idGames = _preferences.getStringList(_keyGames) ?? <String>[];
    final newIdGames = List.of(idGames)..add(game.id);

    await _preferences.setStringList(_keyGames, newIdGames);
    setGame(game);
  }

  static List<Game> getGames() {
    final idGames = _preferences.getStringList(_keyGames);

    if (idGames == null) {
      return <Game>[];
    } else {
      return idGames.map<Game>(getGame).toList();
    }
  }



}