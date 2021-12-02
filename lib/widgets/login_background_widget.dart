import 'package:flutter/material.dart';

class LoginBackgroundWidget extends StatelessWidget {
  final Widget child;
  const LoginBackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("lib/assets/images/login_top2.png"),
            width: size.width * 0.3,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset("lib/assets/images/login_bottom.png"),
            width: size.width * 0.4,
          ),
          child,
        ],
      ),
    );
  }
}
