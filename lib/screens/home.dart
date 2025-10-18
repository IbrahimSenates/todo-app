import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";
import "package:todo_app_2/constants/color.dart";
import "package:todo_app_2/service/data_base_service.dart";

import "package:todo_app_2/widgets/header_widget.dart";
import "package:todo_app_2/screens/add_new_task.dart";

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Builder(
                  builder: (context) {
                    final incomplete = _databaseService.currentTodos
                        .where((t) => !t.isCompleted)
                        .toList();
                    if (incomplete.isEmpty) {
                      return Center(child: Text("No tasks"));
                    }
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: incomplete.length,
                      itemBuilder: (context, index) {
                        final listTodo = incomplete[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.green,
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
                                Icon(Icons.done, color: Colors.white, size: 50),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Text(
                                    'Tamamlandı',
                                    style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
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
                              children: [
                                Expanded(
                                  child: Align(
                                    alignment: AlignmentGeometry.centerRight,

                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      child: Text(
                                        'Kaldır',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),

                                Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                  size: 50,
                                ),
                              ],
                            ),
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              // Sağdan sola kaydırma → Silme işlemi
                              await _databaseService.deleteTodo(listTodo.id);
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              await _databaseService.updateCompleted(
                                listTodo.id,
                              );
                              setState(() {
                                listTodo.isCompleted = !listTodo.isCompleted;
                              });
                            }

                            await _getTodoList();
                          },
                          key: Key(listTodo.id.toString()),
                          child: TodoItem(
                            task: listTodo,
                            onUpdate: _getTodoList,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: Builder(
                  builder: (context) {
                    final completed = _databaseService.currentTodos
                        .where((t) => t.isCompleted)
                        .toList();
                    if (completed.isEmpty) {
                      return Center(child: Text("No tasks"));
                    }
                    return ListView.builder(
                      primary: false,
                      shrinkWrap: true,
                      itemCount: completed.length,
                      itemBuilder: (context, index) {
                        final listTodo = completed[index];

                        return Dismissible(
                          direction: DismissDirection.horizontal,
                          background: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(25),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.done,
                              color: Colors.white,
                              size: 30,
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
                            child: Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          onDismissed: (direction) async {
                            if (direction == DismissDirection.endToStart) {
                              // Sağdan sola kaydırma → Silme işlemi
                              await _databaseService.deleteTodo(listTodo.id);
                            } else if (direction ==
                                DismissDirection.startToEnd) {
                              await _databaseService.updateCompleted(
                                listTodo.id,
                              );
                              setState(() {
                                listTodo.isCompleted = !listTodo.isCompleted;
                              });
                            }

                            await _getTodoList();
                          },
                          key: Key(listTodo.id.toString()),
                          child: TodoItem(
                            task: listTodo,
                            onUpdate: _getTodoList,
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
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
