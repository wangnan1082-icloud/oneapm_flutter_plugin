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
          title: const Text('OneAPM Plugin example'),
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
              onTap: () async {
                dynamic s = await OneapmFlutterPlugin.getSDKVersion;
                print('OneapmFlutterPlugin.getSDKVersion22: $s');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle_sharp),
              title: Text('设置用户名\n '),
              onTap: () async {
                dynamic s =
                    await OneapmFlutterPlugin.setUserName("TestUserName");
                print('OneapmFlutterPlugin.setUserName: $s');
              },
            ),
            ListTile(
              leading: Icon(Icons.event_available),
              title: Text('设置Host地址 为 7.13\n '),
              onTap: () async {
                dynamic s = await OneapmFlutterPlugin.setHostAndPortAndSecurity(
                    "10.128.7.13", "38081", "0");
                print('OneapmFlutterPlugin.setHostAndPortAndSecurity: $s');
              },
            ),
            ListTile(
              leading: Icon(Icons.event_available_sharp),
              title: Text('设置Token 为 爱奇艺\n '),
              onTap: () async {
                dynamic s = await OneapmFlutterPlugin.startWithApplicationToken(
                    "b50c882b-193f-4711-9a0f-998bb97fc412");
                print('OneapmFlutterPlugin.startWithApplicationToken: $s');
              },
            ),
            ListTile(
              leading: Icon(Icons.event),
              title: Text('设置Action\n '),
              onTap: () async {
                dynamic s = await OneapmFlutterPlugin.setCustomAction(
                    "viewNameStr", "actionNameStr");
                print('OneapmFlutterPlugin.setCustomAction: $s');
              },
            ),
          ],
        ),
      ),
    );
  }
}
