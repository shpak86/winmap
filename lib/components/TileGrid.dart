import 'dart:async';

import 'package:tcp_scanner/tcp_scanner.dart';
import 'package:winmap/AuthorizationProvider.dart';
import 'package:winmap/components/ScreenTile.dart';
import 'package:flutter/material.dart';

import '../Scanner.dart';

class TileGrid extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TileGridState();
  }
}

class TileGridState extends State<TileGrid> {
  bool _authorized = false;
  double _scanProgress = 0.0;
  ScanStatuses _scanerStatus = ScanStatuses.unknown;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    AuthorizationProvider.check().then((authorized) {
      setState(() {
        _authorized = authorized;
      });
    });
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _scanerStatus = Scanner.status;
        _scanProgress = Scanner.percent;
      });
    });
  }

  getScannerColor() {
    Color result = Colors.white10;
    if (_scanerStatus == ScanStatuses.scanning) {
      result = Colors.amber;
    } else if (_scanerStatus == ScanStatuses.finished) {
      result = Colors.green;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 3,
      children: <Widget>[
        ScreenTile(
          label: "Device",
          icon: Icons.perm_device_information,
          route: "/hardware_information",
          tag: "hardware_information",
        ),
        ScreenTile(
          label: "Android",
          icon: Icons.android,
          route: "/android_information",
          tag: "android_information",
        ),
        ScreenTile(
          label: "Connection",
          icon: Icons.wifi,
          route: "/connection",
          tag: "connection",
        ),
        ScreenTile(
          label: "Networks",
          icon: Icons.leak_add,
          route: "/networks",
          tag: "networks",
        ),
        ScreenTile(
          label: _scanerStatus == ScanStatuses.unknown ? "Сканер" : _scanProgress.toStringAsPrecision(3) + "%",
          color: getScannerColor(),
          icon: Icons.import_export,
          route: "/scanner",
          tag: "scanner",
        ),
        ScreenTile(
          label: "Speed",
          icon: Icons.network_check,
          route: "/speedometer",
          tag: "speedometer",
        ),

        ScreenTile(
          label: "Report",
          icon: Icons.assignment_turned_in,
          route: "/report",
          tag: "report",
          color: AuthorizationProvider.authorized == true ? Colors.white10 : Colors.red[400],
        ),
        ScreenTile(
          label: "View",
          icon: Icons.assignment_returned,
          route: "/report_viewer",
          tag: "report_viewer",
        ),
        ScreenTile(
          label: "Settings",
          icon: Icons.settings,
          route: "/configuration",
          tag: "configuration",
          color: AuthorizationProvider.authorized ? Colors.white10 : Colors.red[400],
        ),
      ],
    );
  }

  @override
  void dispose() {
    _timer.cancel();
  }
}
