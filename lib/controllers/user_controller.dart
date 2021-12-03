// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static late SharedPreferences _preferences;
  static late SharedPreferences _allUsers;

  static const _keyUsers = 'users';
  static String? currentUser;

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    _allUsers = await SharedPreferences.getInstance();
  }

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    final idUser = user.id;
    final userName = user.name;

    await _allUsers.setString(userName, json);
    await _preferences.setString(idUser, json);
  }

  static User getUser(String? idUser) {
    final json = _preferences.getString(idUser);
    currentUser = idUser;
    return User.fromJson(jsonDecode(json));
  }

  static User getUserByName(String? userName) {
    if (_allUsers.containsKey(userName)) {
      final json = _allUsers.getString(userName);
      currentUser = userName;
      return User.fromJson(jsonDecode(json));
    } else {
      // ignore: prefer_const_constructors
      return User(dateOfBirth: DateTime.now(), name: "Wrong");
    }
  }

  String? getCurrentUser() {
    return currentUser;
  }

  static Future addUsers(User user) async {
    final idUsers = _preferences.getStringList(_keyUsers) ?? <String>[];
    final userNames = _allUsers.getStringList(_keyUsers) ?? <String>[];
    final newIdUsers = List.of(idUsers)..add(user.id);
    final newNames = List.of(userNames)..add(user.name);

    await _preferences.setStringList(_keyUsers, newIdUsers);
    await _allUsers.setStringList(_keyUsers, newNames);
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

  static List<User> getUserNames() {
    final names = _allUsers.getStringList(_keyUsers);

    // ignore: unnecessary_null_comparison
    if (names == null) {
      return <User>[];
    } else {
      return names.map<User>(getUserByName).toList();
    }
  }

  static Future deleteUser(String? idUser) async {
    final idUsers = _preferences.getStringList(_keyUsers) ?? <String>[];
    final newIdUsers = List.of(idUsers)..remove(idUser);

    await _preferences.setStringList(_keyUsers, newIdUsers);
  }

  static User userValidation(User user) {
    List<User> users = getUsers();
    if (users != []) {
      List<String> result = [];

      for (int i = 0; i < users.length; i++) {
        if (users[i].name == user.name && users[i].password == user.password) {
          return users[i];
        } else {
          return user;
        }
      }
    }

    return user;
  }
}
