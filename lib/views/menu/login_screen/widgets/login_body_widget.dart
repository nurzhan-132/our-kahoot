import 'package:flutter/material.dart';
import '/views/creator/game_creator_screen.dart';
import '/views/user/game_user_screen.dart';
import '/controllers/user_controller.dart';
import '/animations/custom_page_route.dart';
import '../../user_screen/registration_screen.dart';
import '../../widgets/rounded_button_widget.dart';
import 'login_background_widget.dart';
import '/models/user.dart';

class LoginBodyWidget extends StatefulWidget {
  const LoginBodyWidget({Key? key}) : super(key: key);

  @override
  _LoginBodyWidgetState createState() => _LoginBodyWidgetState();
}

class _LoginBodyWidgetState extends State<LoginBodyWidget> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: LoginBackgroundWidget(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            "LOGIN",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          Image.asset(
            "lib/assets/images/login_top.png",
            height: size.height * 0.244,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 190, 199, 1),
                borderRadius: BorderRadius.circular(29)),
            child: TextFormField(
              controller: _nameController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                hintText: "Your login",
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            width: size.width * 0.8,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
                color: const Color.fromRGBO(244, 190, 199, 1),
                borderRadius: BorderRadius.circular(29)),
            child: TextFormField(
              obscureText: true,
              controller: _passwordController,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: Colors.white,
                ),
                suffixIcon: Icon(
                  Icons.visibility,
                  color: Colors.white,
                ),
                hintText: "Password",
                border: InputBorder.none,
              ),
            ),
          ),
          RoundedButtonWidget(
              text: "LOGIN",
              press: checkLogin,
              color: const Color(0xFF6F35A5),
              textColor: Colors.white),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Don't have an Account? ",
                style: TextStyle(
                  color: Color(0xFF6F35A5),
                ),
              ),
              GestureDetector(
                  onTap: () => Navigator.of(context).push(CustomPageRoute(
                        child: const RegistrationScreen(),
                      )),
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6F35A5),
                    ),
                  ))
            ],
          ),
        ]),
      ),
    );
  }

  void checkLogin() {
    final form = _formKey.currentState;

    if (!form!.validate()) {
      return;
    }

    final name = _nameController.text;
    final password = _passwordController.text;

    User user =
        User(name: name, password: password, dateOfBirth: DateTime.now());
    String userId = UserController.userValidation(user);

    if (userId.isNotEmpty) {
      User newUser = UserController.getUser(userId);

      if (newUser.settings.isCreator == true) {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GameCreatorScreen(idUser: newUser.id)));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => GameUserScreen(idUser: newUser.id)));
      }
    } else {
      print('nope');
    }
  }
}
