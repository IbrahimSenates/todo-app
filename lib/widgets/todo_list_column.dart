import 'package:flutter/material.dart';
import 'package:todo_app_2/screens/task_screen.dart';
import 'package:todo_app_2/service/data_base_service.dart';
import 'package:todo_app_2/widgets/todoitem.dart';

class TodoListColumn extends StatefulWidget {
  const TodoListColumn({
    super.key,
    required this.databaseService,
    required this.showCompleted,
    required this.onUpdate,
  });

  final DataBaseService databaseService;
  final bool showCompleted;
  final VoidCallback onUpdate;

  @override
  State<TodoListColumn> createState() => _TodoListColumnState();
}

class _TodoListColumnState extends State<TodoListColumn> {
  @override
  Widget build(BuildContext context) {
    final todos = widget.databaseService.currentTodos
        .where((t) => t.isCompleted == widget.showCompleted)
        .toList();

    if (todos.isEmpty) {
      return Center(
        child: Center(
          child: widget.showCompleted
              ? Text(
                  "Bitirilmiş görev yok",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                )
              : Text(
                  "Eklenmiş çalışma yok",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade500,
                  ),
                ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: ListView.builder(
        primary: false,
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (context, index) {
          final todo = todos[index];

          final isCompleted = widget.showCompleted;
          final primaryText = isCompleted ? "Tamamlanmadı" : "Tamamlandı";
          final primaryColor = isCompleted
              ? Colors.yellow.shade700
              : Colors.green;
          final secondaryText = "Kaldır";

          return Dismissible(
            key: Key(todo.id.toString()),
            direction: DismissDirection.horizontal,
            background: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  isCompleted
                      ? Icon(
                          Icons.arrow_circle_left_rounded,
                          color: Colors.white,
                          size: 50,
                        )
                      : Icon(Icons.done, color: Colors.white, size: 50),
                  SizedBox(width: 10),
                  Text(
                    primaryText,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            secondaryBackground: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.redAccent.shade400,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    secondaryText,
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.delete, color: Colors.white, size: 50),
                ],
              ),
            ),
            onDismissed: (direction) async {
              if (direction == DismissDirection.endToStart) {
                await widget.databaseService.deleteTodo(todo.id);
              } else if (direction == DismissDirection.startToEnd) {
                await widget.databaseService.updateCompleted(todo.id);
              }

              widget.onUpdate();
            },
            child: GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TaskScreen(task: todo)),
              ),
              child: TodoItem(task: todo, onUpdate: widget.onUpdate),
            ),
          );
        },
      ),
    );
  }
}
