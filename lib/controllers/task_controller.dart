import 'package:flutter_app_cha/models/task.dart';

class TaskController {
  final List<Task> _tasks = [];

  /// Add a new task to the list
  void addTask(Task task) {
    _tasks.add(task);
  }

  /// Delete a task at the given index
  void deleteTask(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
    }
  }

  /// Toggle the completed status of a task
  void toggleStatus(int index) {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].completed = !_tasks[index].completed;
    }
  }

  /// Get all tasks
  List<Task> get tasks => _tasks;

  /// Get total number of tasks
  int get totalCount => _tasks.length;

  /// Get number of completed tasks
  int get completedCount => _tasks.where((task) => task.completed).length;

  /// Get number of pending tasks
  int get pendingCount => _tasks.where((task) => !task.completed).length;
}
