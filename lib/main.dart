import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app_2/screens/splash_screen.dart';
import 'package:todo_app_2/service/data_base_service.dart';
import 'package:todo_app_2/service/notification_service.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataBaseService.initialize();
  await initializeDateFormatting('tr_TR', null);
  await NotificationHelper().initNotification();

  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome') ?? false;
  runApp(MyApp(showHome: showHome));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.showHome});
  final bool showHome;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(showHome: showHome),
      locale: Locale('tr', 'TR'),
      supportedLocales: [Locale('tr', 'TR')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
