import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationHelper {
  static final notificationPlugin = FlutterLocalNotificationsPlugin();

  bool _isInitialized = false;

  bool get isInitialized => _isInitialized;

  Future<void> initNotification() async {
    if (_isInitialized) return;

    tz.initializeTimeZones();
    final currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

    const AndroidInitializationSettings initSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(android: initSettingsAndroid);
    await notificationPlugin.initialize(initSettings);
    final androidImplementation = notificationPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >();

    final bool? granted = await androidImplementation
        ?.requestNotificationsPermission();
    print("Bildirim izni verildi mi? $granted");

    _isInitialized = true;
  }

  NotificationDetails notificationDetails(int id) {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'todo_channel_$id',
        'ToDo $id',
        channelDescription: 'ToDo List Channel for item $id',
        importance: Importance.high,
        priority: Priority.high,
      ),
    );
  }

  Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
  }) async {
    return notificationPlugin.show(id, title, body, notificationDetails(id));
  }

  Future<int> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required int year,
    required int month,
    required int day,
    required int hour,
    required int minute,
  }) async {
    final scheduledDate = tz.TZDateTime(
      tz.local,
      year,
      month,
      day,
      hour,
      minute,
    );

    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(id),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      matchDateTimeComponents:
          null, // sadece bu tarihte, bu saatte 1 kez çalışsın
    );

    return id;
  }

  Future<void> cancelAllNotification() async {
    await notificationPlugin.cancelAll();
  }

  Future<void> deleteNotification({required int id}) async {
    await notificationPlugin.cancel(id);
    print('Başarlı');
  }

  Future<void> enableNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
    String? time,
  }) async {
    final now = tz.TZDateTime.now(tz.local);

    // Saat bilgisi
    final timeParts = time?.split(":");
    final scheduledDate = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      timeParts != null ? int.parse(timeParts[0]) : 0,
      timeParts != null ? int.parse(timeParts[1]) : 0,
    );

    if (scheduledDate.isBefore(now)) return; // geçmiş için iptal

    await notificationPlugin.zonedSchedule(
      id,
      title,
      body,
      scheduledDate,
      notificationDetails(id),
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,

      matchDateTimeComponents: null,
    );
  }
}
