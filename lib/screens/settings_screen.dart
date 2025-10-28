import 'dart:io';
import 'package:flutter/material.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool autoStartEnabled = false;
  bool batteryOptimizationDisabled = true;
  bool notificationEnabled = false;

  String packageName = "";

  @override
  void initState() {
    super.initState();
    _initPackageName();
    _checkPermissions();
  }

  Future<void> _initPackageName() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      packageName = info.packageName;
    });
  }

  Future<void> _checkPermissions() async {
    final notifStatus = await Permission.notification.status;
    setState(() {
      notificationEnabled = notifStatus.isGranted;
      // autoStartEnabled ve batteryOptimizationDisabled
      // burada gerçek cihaz kontrolü yapabilirsiniz
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ayarlar")),
      body: Column(
        children: [
          settingItem(
            title: "Otomatik Başlat",
            isEnabled: autoStartEnabled,
            onPressed: () => openAutoStartSettings(context),
          ),
          settingItem(
            title: "Pil Optimizasyonu",
            isEnabled: batteryOptimizationDisabled,
            onPressed: () => openBatteryOptimizationSettings(context),
          ),
          settingItem(
            title: "Bildirimler",
            isEnabled: notificationEnabled,
            onPressed: () => openNotificationSettings(context),
          ),
        ],
      ),
    );
  }

  Widget settingItem({
    required String title,
    required bool isEnabled,
    required VoidCallback onPressed,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isEnabled ? Colors.green : Colors.red,
            ),
          ),
          SizedBox(width: 15),
          Expanded(child: Text(title, style: TextStyle(fontSize: 18))),
          ElevatedButton(onPressed: onPressed, child: Text("Git")),
        ],
      ),
    );
  }

  void openAutoStartSettings(BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      final intent = AndroidIntent(
        action: 'miui.intent.action.OP_AUTO_START',
        package: 'com.miui.securitycenter',
      );
      await intent.launch();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Otomatik başlat ayarına erişilemiyor.")),
      );
    }
  }

  void openBatteryOptimizationSettings(BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      final intent = AndroidIntent(
        action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
      );
      await intent.launch();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Pil optimizasyonu ayarına erişilemiyor.")),
      );
    }
  }

  void openNotificationSettings(BuildContext context) async {
    if (!Platform.isAndroid) return;

    try {
      final intent = AndroidIntent(
        action: 'android.settings.APP_NOTIFICATION_SETTINGS',
        arguments: <String, dynamic>{
          'android.provider.extra.APP_PACKAGE': packageName, // Bu önemli
        },
      );
      await intent.launch();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Bildirim ayarlarına erişilemiyor.")),
      );
    }
  }
}
