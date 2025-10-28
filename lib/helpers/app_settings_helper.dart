import 'package:android_intent_plus/android_intent.dart';
import 'dart:io';

Future<void> openAutoStartSettings() async {
  if (!Platform.isAndroid) return;

  try {
    // Xiaomi cihazlar için
    final intent = AndroidIntent(
      action: 'miui.intent.action.OP_AUTO_START',
      package: 'com.miui.securitycenter',
    );

    await intent.launch();
  } catch (e) {
    print('Auto-start ayarları açılamadı: $e');
  }
}

Future<void> openBatteryOptimizationSettings() async {
  if (!Platform.isAndroid) return;

  try {
    final intent = AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    );

    await intent.launch();
  } catch (e) {
    print('Pil optimizasyon ayarları açılamadı: $e');
  }
}
