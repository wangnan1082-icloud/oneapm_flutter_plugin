
import 'dart:async';

import 'package:flutter/services.dart';

class OneapmFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('oneapm_flutter_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 返回版本号
  static Future<Map<String, dynamic>?> getSDKVersion() async {
    return await _channel.invokeMapMethod<String, dynamic>("getSDKVersion");
  }
}
