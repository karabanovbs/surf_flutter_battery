import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:surf_flutter_battery/surf_flutter_battery.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double? _batteryLevel;

  @override
  void initState() {
    super.initState();
    initBatteryLevelListener();
  }

  Future<void> initBatteryLevelListener() async {
    try {
      SurfFlutterBattery((level) {
        setState(() {
          _batteryLevel = level;
        });
      });
    } on PlatformException {
      print('Failed to get Battery Level.');
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Battery Level: ${_batteryLevel ?? "Unknown"}'),
        ),
      ),
    );
  }
}
