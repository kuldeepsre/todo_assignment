
import 'package:hive/hive.dart';

class Task {
  String title;
  bool isShared;

  Task(this.title, this.isShared);
}

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
