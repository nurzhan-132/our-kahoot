import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';
import '../widgets/title_widget.dart';
import 'game_creator_screen.dart';
import 'game_user_screen.dart';
import 'home_screen.dart';
import '../animations/ltor_page_route.dart';
import '../animations/custom_page_route.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late List<User> users;

  @override
  void initState() {
    super.initState();

    users = UserController.getUsers();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.green,
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
                child: IconButton(
                  icon: Icon(Icons.arrow_back, size: 32),
                  onPressed: () => Navigator.of(context).push(LtorPageRoute(
                    child: HomeScreen(),
                  )),
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
      onTap: () => setScreen(user),
      leading: user.imagePath.isEmpty
          ? null
          : CircleAvatar(backgroundImage: FileImage(imageFile)),
      title: Text(user.name, style: TextStyle(fontSize: 24)),
    );
  }

  void setScreen(User user) {
    if (user.settings.isCreator == true) {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (_) => GameCreatorScreen(idUser: user.id)));
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => GameUserScreen(idUser: user.id)));
    }
  }
}
