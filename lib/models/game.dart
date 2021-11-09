import './task.dart';
import '../repositories/repository.dart';

class Game {
  final String id;
  String name;
  String description;
  List<Task> tasks;

  Game(
      {required this.id, this.name = 'Game',
      this.description = 'Some description...', this.tasks = const[]});

  String numberOfTasksMessage() {
    if (tasks.length == 1) {
      return 'There is ${tasks.length} task';
    }
    return 'There are ${tasks.length} tasks';
  }
  
  Game copy({
    String? id,
    String? name,
    String? description,
    List<Task>? tasks,
  }) =>
      Game(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        tasks: tasks ?? this.tasks,
      );

  static Game fromJson(Map<String, dynamic> json) => Game(
    id: json['id'],
    name: json['name'],
    description: json['description'],
    tasks: json['tasks']
                ?.map<Task>((task) => Task.fromJson(task))
                ?.toList() ??
            <Task>[],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'tasks': tasks.map((task) => task.toJson()).toList(),
  };

  @override
  String toString() => 'Game{id: $id, name: $name}';
}
