import './task.dart';

class Game {
  final int id;
  String name;
  List<Task> tasks = [];

  Game({required this.id, this.name = ''});
}