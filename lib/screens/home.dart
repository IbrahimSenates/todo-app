import "package:flutter/material.dart";
import "package:hexcolor/hexcolor.dart";
import "package:todo_app_2/constants/color.dart";
import "package:todo_app_2/service/data_base_service.dart";
import "package:todo_app_2/widgets/header_widget.dart";
import "package:todo_app_2/screens/add_new_task.dart";
import "package:todo_app_2/widgets/todo_list_column.dart";
import 'package:flutter/services.dart';
import 'package:todo_app_2/helpers/app_settings_helper.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

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

  // İlk açılışta kullanıcıya sor
  Future<void> _checkAndAskSettings() async {
    if (!Platform.isAndroid) return;

    final prefs = await SharedPreferences.getInstance();
    bool? alreadyAsked = prefs.getBool('settingsAsked');

    if (alreadyAsked == null || alreadyAsked == false) {
      // Dialog göster
      bool userAccepted = await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Uygulama Ayarları'),
          content: Text(
            'Uygulamanın düzgün çalışması için Auto-Start ve Pil Optimizasyon ayarlarını açmak ister misiniz?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('Hayır'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text('Evet'),
            ),
          ],
        ),
      );

      if (userAccepted == true) {
        openAutoStartSettings();
        openBatteryOptimizationSettings();
      }

      // Kullanıcının yanıtını kaydet
      prefs.setBool('settingsAsked', true);
    }
  }

  @override
  void initState() {
    _getTodoList();
    super.initState();
    _checkAndAskSettings(); //sadece bir kez sorulacak
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(
        statusBarColor: Colors.black, // Bildirim çubuğu rengi beyaz
        statusBarIconBrightness: Brightness.dark, // İkonlar koyu olur
      ),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: HexColor(backGroundColor),
          body: Stack(
            children: [
              //Header
              HeaderItem(),

              //Top Column
              Positioned(
                left: 10,
                top: 110,
                right: 10,
                height: 270,
                child: TodoListColumn(
                  databaseService: _databaseService,
                  showCompleted: false,
                  onUpdate: _getTodoList,
                ),
              ),

              //Completed
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: Align(
                  alignment: AlignmentGeometry.centerLeft,
                  child: Text(
                    'Tamamlanan',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),

              //Bottom Column
              Positioned(
                left: 10,
                bottom: 90,
                right: 10,
                height: 270,
                child: TodoListColumn(
                  databaseService: _databaseService,
                  showCompleted: true,
                  onUpdate: _getTodoList,
                ),
              ),
              Positioned(
                bottom: 30,
                left: 30,
                right: 30,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      HexColor(buttonColor),
                    ),
                  ),
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => AddNewTaskScreen()),
                    );
                    if (result == true) {
                      await _getTodoList();
                    }
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
            ],
          ),
        ),
      ),
    );
  }
}
