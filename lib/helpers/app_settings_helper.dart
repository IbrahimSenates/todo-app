import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

void openAutoStartSettings() {
  if (!Platform.isAndroid) return;

  //Xiaomi cihazlar için
  final intent = AndroidIntent(
    action: 'miui.intent.action.OP_AUTO_START',
    package: 'com.miui.securitycenter',
  );
}

void openBatteryOptimizationSettings() {
  if (!Platform.isAndroid) return;
  final intent = AndroidIntent(
    action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
  );
}
