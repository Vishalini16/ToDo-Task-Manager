class Task {
  String id;
  String title;
  String description;
  DateTime dueDate;
  bool isCompleted;
  int priority;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    this.priority = 1,
  });
}
