import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'user_screen.dart';
import '../widgets/button_widget.dart';
import '../widgets/title_widget.dart';
import '../animations/custom_page_route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 96),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const TitleWidget(icon: Icons.home, text: 'Signup'),
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
            text: 'Login',
            onClicked: () => Navigator.of(context).push(CustomPageRoute(
              child: const LoginScreen(),
            )),
          ),
          const SizedBox(height: 24),
          ButtonWidget(
            text: 'Register',
            onClicked: () => Navigator.of(context).push(CustomPageRoute(
              child: const UserScreen(),
            )),
          ),
        ],
      );
}
