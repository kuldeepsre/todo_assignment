class Task {
  final String id;
  final String name;
  final String owner;
  final List<String> sharedWith;

  Task({required this.id, required this.name, required this.owner, required this.sharedWith});
}