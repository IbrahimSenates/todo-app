import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:todo_app_2/constants/color.dart';
import 'package:todo_app_2/service/data_base_service.dart';
import 'package:todo_app_2/widgets/input_widget.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  String taskType = 'Default';

  final _databaseService = DataBaseService();

  Future<void> _addTodo() async {
    DateTime selectedDate;
    if (dateController.text.isEmpty) {
      selectedDate = await DateTime.now(); // Tarih seçilmediyse bugünün tarihi
    } else {
      selectedDate = DateFormat('dd.MM.yyyy').parse(dateController.text);
    }
    await _databaseService.addTodo(
      titleController.text,
      taskType,
      selectedDate,
      timeController.text,
      descriptionController.text,
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: HexColor(backGroundColor),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                width: deviceWidth,
                height: deviceHeight / 9,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('lib/assets/images/newTaskHeader.png'),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.close, size: 40),
                      color: Colors.white,
                    ),
                    Expanded(
                      child: Text(
                        'Yeni Görev Ekle',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //Başlık alanı
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Başlık',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsetsGeometry.symmetric(horizontal: 30),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    hintText: 'Bir başlık giriniz...',
                    hintStyle: TextStyle(
                      color: Colors.grey.shade500,
                      fontSize: 16,
                      fontStyle: FontStyle.italic,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: HexColor(mainColor),
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              //Kategori alanı
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Kategori',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text('Kategori Seçildi'),
                          ),
                        );
                        setState(() {
                          taskType = 'Default';
                        });
                      },
                      child: Image.asset('lib/assets/icons/category_task.png'),
                    ),

                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text('Kategori Seçildi'),
                          ),
                        );
                        setState(() {
                          taskType = 'Calendar';
                        });
                      },
                      child: Image.asset('lib/assets/icons/category_event.png'),
                    ),

                    GestureDetector(
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            duration: Duration(milliseconds: 300),
                            content: Text('Kategori Seçildi'),
                          ),
                        );
                        setState(() {
                          taskType = 'Contest';
                        });
                      },
                      child: Image.asset('lib/assets/icons/category_goal.png'),
                    ),
                  ],
                ),
              ),

              //Tarih zaman alanı
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    InputWidget(
                      text: 'Tarih',
                      controllerInput: dateController,
                      picker: 'Tarih',
                    ),
                    InputWidget(
                      text: 'Zaman',
                      controllerInput: timeController,
                      picker: 'Saat',
                    ),
                  ],
                ),
              ),

              //Açıklama alanı
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  'Açıklama',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 250,
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),

                  child: TextField(
                    style: TextStyle(fontSize: 21),
                    controller: descriptionController,

                    maxLines: 12,
                    decoration: InputDecoration(
                      hintText: 'Görev hakkında detaylı açıklama girin...',
                      hintStyle: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                        fontStyle: FontStyle.italic,
                      ),
                      filled: true,
                      fillColor: Colors.white,

                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 20,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(width: 2.0, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: HexColor(mainColor),
                          width: 2.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 15, right: 30, left: 30),
                child: SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(
                        HexColor(buttonColor),
                      ),
                    ),
                    onPressed: () async {
                      if (titleController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Lütfen bir başlık girin'),
                            backgroundColor: Colors.redAccent,
                            duration: Duration(seconds: 1),
                          ),
                        );
                        return;
                      }
                      await _addTodo();
                      Navigator.pop(context, true);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Görev başarıyla eklendi'),
                          backgroundColor: Colors.green,
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text(
                        'Yeni Görev Ekle',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
