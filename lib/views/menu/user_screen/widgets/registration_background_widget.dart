import 'package:flutter/material.dart';

class RegistrationBackgroundWidget extends StatelessWidget {
  final Widget child;
  const RegistrationBackgroundWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset("lib/assets/images/main_top.png"),
          ),
          Positioned(
            top: 60,
            right: 60,
            child: Image.asset(
              "lib/assets/images/main_center.png",
              width: size.width * 0.3,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset("lib/assets/images/main_bottom.png"),
          ),
          child,
        ],
      ),
    );
  }
}