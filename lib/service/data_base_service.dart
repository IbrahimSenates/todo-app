import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_app_2/model/todo_model.dart';

class DataBaseService {
  static late Isar isar;

  //Isar başlat
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([TodoSchema], directory: dir.path);
  }

  //Todo listesi oluştur
  List<Todo> currentTodos = [];

  //Görev ekle
  Future<int> addTodo(
    String text,
    String category,
    DateTime date,
    String time,
    String description,
  ) async {
    final newTodo = Todo()
      ..text = text
      ..category = category
      ..dateTime = date
      ..time = time
      ..description = description;
    isar.writeTxn(() => isar.todos.put(newTodo));
    await fetchTodos();
    return newTodo.id;
  }

  //Görevleri getir
  Future<void> fetchTodos() async {
    currentTodos = await isar.todos.where().findAll();
  }

  //Görevleri sil
  Future<void> deleteTodo(Id id) async {
    await isar.writeTxn(() async {
      await isar.todos.delete(id);
    });
    await fetchTodos();
  }

  //isCompleted update
  Future<void> updateCompleted(int id) async {
    final updateTodo = await isar.todos.get(id);
    if (updateTodo != null) {
      updateTodo.isCompleted = !updateTodo.isCompleted;

      await isar.writeTxn(() async {
        await isar.todos.put(updateTodo);
      });
    }
    await fetchTodos();
  }
}
