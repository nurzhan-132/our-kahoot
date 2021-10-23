import './task.dart';

class Game {
  //final int id;
  String name;
  String description;
  List<Task> tasks = [];

  Game({/*required this.id,*/ this.name = 'Game', this.description = 'Some description...'});
}