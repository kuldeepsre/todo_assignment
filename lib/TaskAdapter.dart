import 'package:hive/hive.dart';
import 'package:task_todo/task.dart';

class TaskAdapter extends TypeAdapter<Task> {
  @override
  final int typeId = 0;

  @override
  Task read(BinaryReader reader) {
    return Task(reader.read(), reader.read());
  }

  @override
  void write(BinaryWriter writer, Task obj) {
    writer.write(obj.title);
    writer.write(obj.isShared);
  }
}