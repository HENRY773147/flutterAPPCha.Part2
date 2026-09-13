class Task {
  final String title;
  final String category;
  final String priority;
  bool completed;

  Task({
    required this.title,
    required this.category,
    required this.priority,
    this.completed = false,
  });

  /// Create a copy of this task with some properties overridden
  Task copyWith({
    String? title,
    String? category,
    String? priority,
    bool? completed,
  }) {
    return Task(
      title: title ?? this.title,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      completed: completed ?? this.completed,
    );
  }
}
