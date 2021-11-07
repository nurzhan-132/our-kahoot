import 'dart:io';

import 'package:flutter/material.dart';
import '../models/user.dart';
import 'user_screen.dart';
import '../utils/user_preferences.dart';
import '../widgets/title_widget.dart';
import '../game_provider.dart';
import 'game_creator_screen.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late List<User> users;

  @override
  void initState() {
    super.initState();

    users = UserPreferences.getUsers();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 96),
            child: Column(
              children: <Widget>[
                TitleWidget(icon: Icons.login, text: 'Login'),
                const SizedBox(height: 48),
                Expanded(child: buildUsers()),
              ],
            ),
          ),
          Positioned(
            left: 16,
            top: 24,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Icon(Icons.arrow_back, size: 32),
            ),
          ),
        ],
      ),
    ),
  );

  Widget buildUsers() {
    if (users.isEmpty) {
      return Center(
        child: Text(
          'There are no users!',
          style: TextStyle(fontSize: 24),
        ),
      );
    } else {
      return ListView.separated(
        itemCount: users.length,
        separatorBuilder: (context, index) => Container(height: 12),
        itemBuilder: (context, index) {
          final user = users[index];

          return buildUser(user);
        },
      );
    }
  }

  Widget buildUser(User user) {
    final imageFile = File(user.imagePath);

    return ListTile(
      tileColor: Colors.white24,
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameProvider(
              child: const MaterialApp(
                home: GameCreatorScreen(),
              )))),
      leading: user.imagePath.isEmpty
          ? null
          : CircleAvatar(backgroundImage: FileImage(imageFile)),
      title: Text(user.name, style: TextStyle(fontSize: 24)),
    );
  }
}