import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '/widgets/login_body_widget.dart';
import '../models/user.dart';
import '../controllers/user_controller.dart';
import '../widgets/title_widget.dart';
import 'game_creator_screen.dart';
import 'game_user_screen.dart';
import 'home_screen.dart';
import '../animations/ltor_page_route.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoginBodyWidget(),
    );
  }

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       body: SafeArea(
  //         child: Stack(
  //           children: [
  //             Container(
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 32, vertical: 96),
  //               child: Column(
  //                 children: <Widget>[
  //                   const TitleWidget(icon: Icons.login, text: 'Login'),
  //                   const SizedBox(height: 48),
  //                   Expanded(child: buildUsers()),
  //                 ],
  //               ),
  //             ),
  //             Positioned(
  //               left: 16,
  //               top: 24,
  //               child: IconButton(
  //                 icon: const Icon(Icons.arrow_back, size: 32),
  //                 onPressed: () => Navigator.of(context).push(LtorPageRoute(
  //                   child: const HomeScreen(),
  //                 )),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );

  // Widget buildUsers() {
  //   if (users.isEmpty) {
  //     return const Center(
  //       child: Text(
  //         'There are no users!',
  //         style: TextStyle(fontSize: 24),
  //       ),
  //     );
  //   } else {
  //     return ListView.separated(
  //       itemCount: users.length,
  //       separatorBuilder: (context, index) => Container(height: 12),
  //       itemBuilder: (context, index) {
  //         final user = users[index];

  //         return buildUser(user);
  //       },
  //     );
  //   }
  // }

  // Widget buildUser(User user) {
  //   final imageFile = File(user.imagePath);

  //   return ListTile(
  //     tileColor: Colors.white24,
  //     onTap: () => setScreen(user),
  //     leading: user.imagePath.isEmpty
  //         ? null
  //         : CircleAvatar(backgroundImage: FileImage(imageFile)),
  //     title: Text(user.name, style: const TextStyle(fontSize: 24)),
  //     trailing: IconButton(
  //       icon: const Icon(Icons.close),
  //       onPressed: () {
  //         UserController.deleteUser(user.id);
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => LoginScreen()));
  //       },
  //     ),
  //   );
  // }

  // void setScreen(User user) {
  //   if (user.settings.isCreator == true) {
  //     Navigator.of(context).push(MaterialPageRoute(
  //         builder: (_) => GameCreatorScreen(idUser: user.id)));
  //   } else {
  //     Navigator.of(context).push(
  //         MaterialPageRoute(builder: (_) => GameUserScreen(idUser: user.id)));
  //   }
  // }
}


