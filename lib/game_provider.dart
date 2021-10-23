import 'package:flutter/cupertino.dart';
import 'models/data_layer.dart';

class GameProvider extends InheritedWidget {
  final _games = <Game>[];

  GameProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static List<Game> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<GameProvider>();
    return provider!._games;
  }
}
