import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_2/constants/color.dart';
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
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: HexColor(buttonColor),
        centerTitle: true,
        title: Text(
          'Göreviniz',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(4.0),
          child: Container(
            color: Colors.grey,
            height: 2.0,
            width: double.infinity,
          ),
        ),
      ),

      body: Container(
        color: HexColor(buttonColor),

        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: AlignmentGeometry.center,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Text(
                    DateFormat('dd.MM.yyyy, E').format(widget.task.dateTime),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.task.time!,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.task.text!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            SizedBox(height: 10),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                widget.task.description!,
                style: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
