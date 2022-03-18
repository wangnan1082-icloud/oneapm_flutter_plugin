import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:oneapm_flutter_plugin/oneapm_flutter_plugin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _sdkVersion = '0.0.00';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    String sdkVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await OneapmFlutterPlugin.platformVersion ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    try {
      sdkVersion =
          await OneapmFlutterPlugin.getSDKVersion ?? 'Unknown platform version';
      print('OneapmFlutterPlugin.getSDKVersion11: $sdkVersion');
    } on PlatformException {
      sdkVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _sdkVersion = sdkVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Running on: $_platformVersion\n'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('获取版本号： $_sdkVersion\n '),
              onTap: () {
                dynamic s = OneapmFlutterPlugin.getSDKVersion;
                print('OneapmFlutterPlugin.getSDKVersion22: $s');

                //('传入你们服务端分配给用户的登录 ID');
              },
            ),
          ],
          // child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}
