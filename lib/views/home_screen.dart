import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'user_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';
import '../animations/custom_page_route.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 96),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TitleWidget(icon: Icons.home, text: 'Our-kahoot'),
                buildButtons(),
              ],
            ),
          ),
        ),
      );

  Widget buildButtons() => Column(
        children: [
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Sign in',
            onClicked: () => Navigator.of(context).push(CustomPageRoute(
              child: LoginScreen(),
            )),
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Sign up',
            onClicked: () => Navigator.of(context).push(CustomPageRoute(
              child: UserScreen(),
            )),
          ),
        ],
      );
}
