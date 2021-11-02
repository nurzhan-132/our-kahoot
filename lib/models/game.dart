import './task.dart';
import '../repositories/repository.dart';

class Game {
  final int id;
  String name;
  String description;
  List<Task> tasks = [];

  Game(
      {required this.id, this.name = 'Game',
      this.description = 'Some description...'});

  String numberOfTasksMessage() {
    if (tasks.length == 1) {
      return 'There is ${tasks.length} task';
    }
    return 'There are ${tasks.length} tasks';
  }

  Game.fromModel(Model model)
      : id = model.id,
        name = model.data['name'] ?? '',
        description = model.data['description'] ?? '',
        tasks = model.data['tasks']
                ?.map<Task>((task) => Task.fromModel(task))
                ?.toList() ??
            <Task>[];

  Model toModel() => Model(id: id, data: {
        'name': name,
        'description': description,
        'tasks': tasks.map((task) => task.toModel()).toList()
      });
}
