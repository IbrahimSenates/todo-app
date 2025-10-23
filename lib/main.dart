import 'package:flutter/material.dart';
import 'package:todo_app_2/screens/home.dart';
import 'package:todo_app_2/service/data_base_service.dart';
import 'package:todo_app_2/service/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseService.initialize();
  await initializeDateFormatting('tr_TR', null);
  NotificationHelper().initNotification();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomeScreen());
  }
}
