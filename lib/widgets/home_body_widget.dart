import 'package:flutter/material.dart';
import '/views/user_screen.dart';
import '/animations/custom_page_route.dart';
import '/views/login_screen.dart';
import '/widgets/rounded_button_widget.dart';
import '/widgets/home_background_widget.dart';

class HomeBodyWidget extends StatelessWidget {
  const HomeBodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return HomeBackgroundWidget(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text(
            "WELCOME TO OUR KAHOOT",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Image.asset("lib/assets/images/main_center2.png"),
          RoundedButtonWidget(
            text: "LOGIN",
            press: () => Navigator.of(context).push(CustomPageRoute(
              child: const LoginScreen(),
            )),
            color: const Color(0xFF6F35A5),
            textColor: Colors.white,
          ),
          RoundedButtonWidget(
            text: "SIGNUP",
            press: () => Navigator.of(context).push(CustomPageRoute(
              child: const UserScreen(),
            )),
            color: const Color.fromRGBO(244, 190, 199, 1),
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
