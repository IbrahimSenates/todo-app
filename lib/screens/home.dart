import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";
import "package:todo_app_2/constants/color.dart";
import "package:todo_app_2/service/data_base_service.dart";

import "package:todo_app_2/widgets/header_widget.dart";
import "package:todo_app_2/screens/add_new_task.dart";
import "package:todo_app_2/widgets/todo_list_column.dart";

import "package:todo_app_2/widgets/todoitem.dart";

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _databaseService = DataBaseService();

  Future<void> _getTodoList() async {
    await _databaseService.fetchTodos();
    setState(() {});
  }

  @override
  void initState() {
    _getTodoList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backGroundColor),
        body: Column(
          children: [
            //Header
            HeaderItem(),

            //Top Column
            TodoListColumn(
              databaseService: _databaseService,
              showCompleted: false,
              onUpdate: _getTodoList,
            ),

            //Completed
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: AlignmentGeometry.centerLeft,
                child: Text(
                  'Completed',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),

            //Bottom Column
            TodoListColumn(
              databaseService: _databaseService,
              showCompleted: true,
              onUpdate: _getTodoList,
            ),
            ElevatedButton(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => AddNewTaskScreen()),
                );
                if (result == true) {
                  await _getTodoList();
                }
              },
              child: Text('Yeni Görev Ekle'),
            ),
          ],
        ),
      ),
    );
  }
}
