import 'dart:async';

import 'package:flutter/services.dart';

const getBatteryLevel = 'getBatteryLevel';

class SurfFlutterBattery {
  final Function(double batteryLevel) _onBatterryPowerChanged;

  SurfFlutterBattery(this._onBatterryPowerChanged) {
    _initBatteryLevelSubScription();
  }

  static const MethodChannel _channel =
      const MethodChannel('surf_flutter_battery');

  void _initBatteryLevelSubScription() {
    _channel.setMethodCallHandler((call) async {
      switch (call.method) {
        case getBatteryLevel:
          _onBatterryPowerChanged.call(call.arguments);
      }
    });
  }
}
