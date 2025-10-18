import 'package:isar/isar.dart';
part 'todo_model.g.dart';

@collection
class Todo {
  Id id = Isar.autoIncrement;
  String? text;
  late DateTime dateTime;
  bool isCompleted = false;
  String category = 'Default';
  String? time;
  String? description;
}
