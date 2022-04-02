import 'dart:async';

import 'package:flutter/services.dart';

class OneapmFlutterPlugin {
  static const MethodChannel _channel =
      const MethodChannel('oneapm_flutter_plugin');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  /// 设置 Token 并启动探针
  static Future<String?> startWithApplicationToken(String token) async {
    return await _channel
        .invokeMethod("startWithApplicationToken", {"token": token});
  }

  /// 设置用户名
  static Future<String?> setUserName(String userName) async {
    return await _channel.invokeMethod("setUserName", {"userName": userName});
  }

  /// setPrintLog
  static Future<String?> setPrintLog(bool isPrintLog) async {
    return await _channel
        .invokeMethod("setPrintLog", {"isPrintLog": isPrintLog});
  }

  ///
  /// 设置 OneAPM 服务器地址
  /// @param host SDK 的服务器地址
  /// @param port SDK 端口地址
  /// @param withSecurity 与服务器的通信使用 https 协议时该值为 YES，使用 http 协议时改值为 NO。根据苹果的审核要求，推荐使用 https 协议。
  ///
  static Future<String?> setHostAndPortAndSecurity(
      String host, String port, String security) async {
    return await _channel.invokeMethod("setHostAndPortAndSecurity",
        {"host": host, "port": port, "security": security});
  }

  ///
  /// 设置自定义Action
  /// @param viewName view的名字
  /// @param actionName actionName名称
  ///
  static Future<String?> setCustomAction(
      String viewNameStr, String actionNameStr) async {
    return await _channel.invokeMethod("setCustomAction",
        {"viewName": viewNameStr, "actionName": actionNameStr});
  }

  /// 返回版本号
  static Future<String?> get getSDKVersion async {
    final String? sdkVersion = await _channel.invokeMethod('getSDKVersion');
    return sdkVersion;
  }
}
