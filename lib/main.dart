import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wifi_info_plugin/wifi_info_plugin.dart';
import 'package:winmap/screens/AndroidInformationScreen.dart';
import 'package:winmap/screens/ConfigurationScreen.dart';
import 'package:winmap/screens/ConnectionScreen.dart';
import 'package:winmap/screens/MainScreen.dart';
import 'package:winmap/screens/NetworksSettingsScreen.dart';
import 'package:winmap/screens/ReportEditorScreen.dart';
import 'package:winmap/screens/NetworksScreen.dart';
import 'package:winmap/screens/ReportViewerScreen.dart';
import 'package:winmap/screens/ScannerScreen.dart';
import 'package:winmap/screens/SpeedometerScreen.dart';
import 'data/ConnectionData.dart';
import 'device/DeviceProvider.dart';
import 'screens/HardwareInformationScreen.dart';

void main() => runApp(WinMapApp());

class WinMapApp extends StatelessWidget {
  static Timer _connectionTimer;
  static Timer _networksTimer;
  static Timer _deviceTimer;

  WinMapApp() {
    if (_connectionTimer != null) _connectionTimer.cancel();
    if (_networksTimer != null) _networksTimer.cancel();
    if (_deviceTimer != null) _deviceTimer.cancel();

    _getConnectionData(null);
    _getNetworksData(null);
    _getDeviceData(null);

    _connectionTimer = Timer.periodic(Duration(seconds: 2), _getConnectionData);
    _networksTimer = Timer.periodic(Duration(seconds: 2), _getNetworksData);
  }

  setSharedPreferences() {}

  _getConnectionData(Timer timer) {
    WifiInfoPlugin.wifiDetails.then((wrapper) {
      DeviceProvider.connectionData = ConnectionData(wrapper.macAddress.split(":").map((item) => item.length == 1 ? "0$item" : item).join(":"), wrapper.ipAddress ?? "unknown", wrapper.linkSpeed.toString() + " Mbit/s", wrapper.frequency.toString() + " MHz", wrapper.ssid == "<unknown ssid>" ? "unknown" : wrapper.ssid, wrapper.signalStrength.toString(), wrapper.connectionType, wrapper.routerIp, wrapper.dns1, wrapper.dns2, wrapper.isHiddenSSid.toString(), wrapper.bssId ?? "unknown");
    });
  }

  _getNetworksData(Timer timer) {
    DeviceProvider.getNetworks();
  }

  _getDeviceData(Timer timer) {
    DeviceProvider.getDeviceProperties();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      routes: {
        "/": (context) => MainScreen(),
        "/report": (context) => ReportScreen(),
        "/hardware_information": (context) => HardwareInformationScreen(),
        "/android_information": (context) => AndroidInformationScreen(),
        "/networks_display_properties": (context) => NetworksDisplayPropertiesScreen(),
        "/connection": (context) => ConnectionScreen(),
        "/configuration": (context) => ConfigurationScreen(),
        "/networks": (context) => NetworksScreen(),
        "/report_viewer": (context) => ReportViewerScreen(),
        "/scanner": (context) => ScannerScreen(),
        "/speedometer": (context) => SpeedometerScreen(),
      },
      theme: ThemeData(
        splashColor: Colors.teal,
//        primarySwatch: Colors.blue,
          brightness: Brightness.dark),
    );
  }
}
