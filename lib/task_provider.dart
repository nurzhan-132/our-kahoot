import 'package:flutter/cupertino.dart';
import 'models/data_layer.dart';

class TaskProvider extends InheritedWidget {
  final _tasks = <Task>[];

  TaskProvider({Key? key, required Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;

  static List<Task> of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<TaskProvider>();
    return provider!._tasks;
  }
}
