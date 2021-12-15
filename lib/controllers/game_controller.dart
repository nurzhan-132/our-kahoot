// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:async';
import 'dart:convert';
import '/controllers/all_controllers.dart';
import '/models/all_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameController {
  static late SharedPreferences _preferences;

  static late String currGame;
  static late String currTask;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static List<Game> getUserGames(User user) {
    final json = _preferences.getString(user.id);
    User nUser = User.fromJson(jsonDecode(json!));

    return nUser.games;
  }

  static Future addGame(Game game) async {
    User user = UserController.getUser(UserController.getCurrentUser());
    user.games.add(game);
    UserController.setUser(user);
  }

  static Future deleteGame(String? gameId) async {
    final json = _preferences.getString(UserController.getCurrentUser());
    User user = User.fromJson(jsonDecode(json!));
    Game ngame = user.games.where((cgame) => cgame.id == gameId).single;
    user.games.remove(ngame);
    UserController.setUser(user);
  }

  static Game getGame(String? idGame) {
    final json = _preferences.getString(UserController.getCurrentUser());
    User user = User.fromJson(jsonDecode(json!));
    Game game = user.games.firstWhere((element) => element.id == idGame);
    return game;
  }

  static Game getGameByUser(String? idGame) {
    List<User> users = UserController.getUsers();

    for (var i = 0; i < users.length; i++) {
      if (users[i].settings.isCreator && users[i].games.isNotEmpty) {
        for (var j = 0; j < users[i].games.length; j++) {
          if (users[i].games[j].id == idGame) {
            final json = _preferences.getString(users[i].id);
            User user = User.fromJson(jsonDecode(json!));
            Game game = user.games[j];
            return game;
          }
        }
      }
    }
    return Game(id: '');
  }

  static Future addTask(Task task) async {
    User user = UserController.getUser(UserController.getCurrentUser());
    Game game = user.games.firstWhere((element) => element.id == currGame);
    game.tasks.add(task);
    UserController.setUser(user);
  }

  static void deleteTask(String taskId) {
    final json = _preferences.getString(UserController.getCurrentUser());
    User user = User.fromJson(jsonDecode(json!));
    Game game = user.games.where((cgame) => cgame.id == currGame).single;
    Task task = game.tasks.where((ctask) => ctask.id == taskId).single;
    game.tasks.remove(task);
    UserController.setUser(user);
  }

  static Task getTask(String? taskId) {
    final json = _preferences.getString(UserController.getCurrentUser());
    User user = User.fromJson(jsonDecode(json!));
    Game game = user.games.where((cgame) => cgame.id == currGame).single;
    Task task = game.tasks.where((ctask) => ctask.id == taskId).single;
    currTask = taskId!;
    return task;
  }

  static Future addAnswer(Answer answer) async {
    User user = UserController.getUser(UserController.getCurrentUser());
    Game game = user.games.firstWhere((element) => element.id == currGame);
    Task task = game.tasks.firstWhere((element) => element.id == currTask);
    task.answers.add(answer);
    UserController.setUser(user);
  }

  static void deleteAnswer(String answerId) {
    final json = _preferences.getString(UserController.getCurrentUser());
    User user = User.fromJson(jsonDecode(json!));
    Game game = user.games.where((cgame) => cgame.id == currGame).single;
    Task task = game.tasks.where((ctask) => ctask.id == currTask).single;
    Answer answer =
        task.answers.where((canswer) => canswer.id == answerId).single;
    task.answers.remove(answer);
    UserController.setUser(user);
  }

  static Future setAnswerCorrectness(String idAnswer, bool correctness) async {
    User user = UserController.getUser(UserController.getCurrentUser());
    Game game = user.games.firstWhere((element) => element.id == currGame);
    Task task = game.tasks.firstWhere((element) => element.id == currTask);
    Answer answer =
        task.answers.firstWhere((element) => element.id == idAnswer);
    answer.correctness = correctness;
    UserController.setUser(user);
  }

  static Future setAnswerText(String idAnswer, String answerText) async {
    User user = UserController.getUser(UserController.getCurrentUser());
    Game game = user.games.firstWhere((element) => element.id == currGame);
    Task task = game.tasks.firstWhere((element) => element.id == currTask);
    Answer answer =
        task.answers.firstWhere((element) => element.id == idAnswer);
    answer.answerText = answerText;
    UserController.setUser(user);
  }

  static List<Game> getAllUsersGames() {
    List<User> users = UserController.getUsers();
    List<Game> games = [];
    for (var i = 0; i < users.length; i++) {
      if (users[i].settings.isCreator) {
        games.addAll(users[i].games);
      }
    }

    return games;
  }

  static String getCurrGame() {
    return currGame;
  }

  static String getCurrTask() {
    return currTask;
  }

  static void setCurrGame(String gameId) {
    currGame = gameId;
  }

  // static int getCurrGameIndex(User user) {
  //   print('why?');
  //   for (var i = 0; i < user.games.length; i++) {
  //     print(currGame + ' ' + user.games[i].id);
  //     if (currGame == user.games[i].id) {
  //       return i;
  //     }
  //   }
  //   return -1;
  // }
}
