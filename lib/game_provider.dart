import 'package:flutter/cupertino.dart';
import 'controllers/game_controller.dart';

class GameProvider extends InheritedWidget {
  final _controller = GameController();

  GameProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static GameController of(BuildContext context) {
    GameProvider? provider =
        context.dependOnInheritedWidgetOfExactType<GameProvider>();
    return provider!._controller;
  }

}
