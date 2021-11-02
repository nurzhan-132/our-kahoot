import '../repositories/in_memory_cache.dart';
import '../repositories/repository.dart';
import '../models/data_layer.dart';

class TaskServices {
  final Repository _repository = InMemoryCache();

  void createTask(String questionText) {
    final model = _repository.create();
    final task = Task.fromModel(model)..questionText = questionText;
    saveTask(task);
  }

  void saveTask(Task task) {
    _repository.update(task.toModel());
  }

  void deleteTask(Task task) {
    _repository.delete(task.toModel());
  }

  List<Task> getAllTasks() {
    return _repository
        .getAll()
        .map<Task>((model) => Task.fromModel(model))
        .toList();
  }

  void createAnswer(Task task, String answerText) {
    final model = _repository.create();
    final answer = Answer.fromModel(model)..answerText = answerText;
    task.answers.add(answer);
    saveTask(task);
  }

  void deleteAnswer(Task task, Answer answer) {
    _repository.delete(answer.toModel());
  }
}