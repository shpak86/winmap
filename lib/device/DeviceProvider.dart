import 'dart:async';

import 'package:flutter/services.dart';
import 'package:winmap/data/TestsData.dart';
import '../data/ConnectionData.dart';
import '../data/DeviceData.dart';
import '../data/NetworkData.dart';

class DeviceProvider {
  static const _platform = const MethodChannel("flutter.native/channel");
  static List<NetworkData> networks = List();
  static DeviceData deviceData;
  static ConnectionData connectionData;
  static TestsData testsData = TestsData([], []);

  static String error = "";

  static Future<DeviceData> getDeviceProperties() async {
    try {
      deviceData = DeviceData.fromJson(await _platform.invokeMethod("getDeviceProperties"));
    } catch (ex) {
      error = ex.toString();
    }
    return deviceData;
  }

  static Future<List<NetworkData>> getNetworks() async {
    try {
      List<dynamic> result = await _platform.invokeMethod("getNetworksList");
      networks = result.map((json) => NetworkData.fromJson(json.toString())).toList();
    } catch (ex) {
      error = ex.toString();
    }
    return networks;
  }
}
