import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app_2/model/todo_model.dart';
import 'package:todo_app_2/service/data_base_service.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task, required this.onUpdate});
  final Todo task;
  final VoidCallback onUpdate;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

bool isChecked = false;

class _TodoItemState extends State<TodoItem> {
  final _databaseService = DataBaseService();
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            widget.task.category == 'Default'
                ? Image.asset('lib/assets/icons/category_task.png', scale: 0.8)
                : widget.task.category == 'Contest'
                ? Image.asset('lib/assets/icons/category_goal.png', scale: 0.8)
                : Image.asset(
                    'lib/assets/icons/category_event.png',
                    scale: 0.8,
                  ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    widget.task.text ?? "Boş görev",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  /* Text(
                    widget.task.description,
                    style: TextStyle(
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),*/
                  Text(DateFormat('dd.MM.yyyy').format(widget.task.dateTime)),
                  Text(widget.task.time.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
