import 'package:flutter/material.dart';

class LtorPageRoute extends PageRouteBuilder {
  final Widget child;

  LtorPageRoute({
    required this.child,
  }) : super(
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, animation, secondaryAnimation) => child,
  );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1,0),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
}