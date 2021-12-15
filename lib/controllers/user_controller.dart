// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import '/models/all_models.dart';
import '/controllers/all_controllers.dart';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static late SharedPreferences _preferences;

  static const _keyUsers = 'users';
  static late String currentUser;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    final idUser = user.id;

    await _preferences.setString(idUser, json);
  }

  static User getUser(String? idUser) {
    final json = _preferences.getString(idUser!);
    return User.fromJson(jsonDecode(json!));
  }

  static String getCurrentUser() {
    return currentUser;
  }

  static void setCurrUser(String userId) {
    currentUser = userId;
  }

  static Future addUsers(User user) async {
    final idUsers = _preferences.getStringList(_keyUsers) ?? <String>[];
    final newIdUsers = List.of(idUsers)..add(user.id);

    await _preferences.setStringList(_keyUsers, newIdUsers);
  }

  static List<User> getUsers() {
    final idUsers = _preferences.getStringList(_keyUsers);

    // ignore: unnecessary_null_comparison
    if (idUsers == null) {
      return <User>[];
    } else {
      return idUsers.map<User>(getUser).toList();
    }
  }

  static Future deleteUser(String? idUser) async {
    final idUsers = _preferences.getStringList(_keyUsers) ?? <String>[];
    final newIdUsers = List.of(idUsers)..remove(idUser);

    await _preferences.setStringList(_keyUsers, newIdUsers);
  }

  static String userValidation(User user) {
    List<User> users = getUsers();
    print(users);
    if (users != []) {
      for (int i = 0; i < users.length; i++) {
        if (users[i].name == user.name && users[i].password == user.password) {
          return users[i].id;
        }
      }
    }

    return '';
  }

  static void setResultToUser(String gameId, int result) async {
    User user = getUser(currentUser);
    if (user.games.isEmpty) {
      Game game = Game(id: gameId, result: result);
      user.games.add(game);
    } else {
      for (var i = 0; i < user.games.length; i++) {
        if (user.games[i].id == gameId) {
          if (result > user.games[i].result) user.games[i].result = result;
          break;
        } else if (user.games[i].id != gameId && i == user.games.length - 1) {
          Game game = Game(id: gameId, result: result);
          user.games.add(game);
        }
      }
    }

    await UserController.setUser(user);
  }

  static Map<String, int> getAllGameResults() {
    List<User> users = getUsers();
    Map<String, int> results = {};

    for (var i = 0; i < users.length; i++) {
      if (!users[i].settings.isCreator && users[i].games.isNotEmpty) {
        for (var j = 0; j < users[i].games.length; j++) {
          if (users[i].games[j].id == GameController.getCurrGame()) {
            results.addAll({users[i].name: users[i].games[j].result});
          }
        }
      }
    }

    return results;
  }
}
