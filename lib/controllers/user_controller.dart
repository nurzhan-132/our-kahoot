// ignore_for_file: import_of_legacy_library_into_null_safe

import 'dart:convert';
import '../models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController {
  static late SharedPreferences _preferences;

  static const _keyUsers = 'users';
  static String? currentUser;

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());
    final idUser = user.id;

    await _preferences.setString(idUser, json);
  }

  static User getUser(String? idUser) {
    final json = _preferences.getString(idUser);
    currentUser = idUser;
    return User.fromJson(jsonDecode(json));
  }

  String? getCurrentUser() {
    return currentUser;
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
}
