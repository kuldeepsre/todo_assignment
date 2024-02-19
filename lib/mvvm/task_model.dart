class Task {
  String id;
  String title;
  bool completed;
  String ownerId;
  DateTime lastUpdated;

  Task({
    required this.id,
    required this.title,
    required this.completed,
    required this.ownerId,
    required this.lastUpdated,
  });
}
