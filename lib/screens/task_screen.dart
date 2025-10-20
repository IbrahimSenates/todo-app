import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_2/model/todo_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key, required this.task});
  final Todo task;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Text(widget.task.text!),
          Text(DateFormat('dd.MM.yyyy').format(widget.task.dateTime)),
          Text(widget.task.time!),
          Text(widget.task.description!),
        ],
      ),
    );
  }
}
