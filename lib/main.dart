import 'package:flutter/material.dart';
import 'package:todo_app_2/screens/home.dart';
import 'package:todo_app_2/service/data_base_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseService.initialize();
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
