import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app_2/model/todo_model.dart';

class TodoItem extends StatefulWidget {
  const TodoItem({super.key, required this.task, required this.onUpdate});
  final Todo task;
  final VoidCallback onUpdate;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

bool isChecked = false;

class _TodoItemState extends State<TodoItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.task.isCompleted ? Colors.grey : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 4, bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              flex: 2,
              child: widget.task.category == 'Default'
                  ? Image.asset(
                      'lib/assets/icons/category_task.png',
                      scale: 1.1,
                    )
                  : widget.task.category == 'Contest'
                  ? Image.asset(
                      'lib/assets/icons/category_goal.png',
                      scale: 1.1,
                    )
                  : Image.asset(
                      'lib/assets/icons/category_event.png',
                      scale: 1.1,
                    ),
            ),
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Text(
                    widget.task.text!,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      decoration: widget.task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),

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
