import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/components/DisplayTable.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/components/TableLabels.dart';
import 'package:winmap/device/DeviceProvider.dart';

class ConnectionScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ConnectionScreenState();
  }
}

class ConnectionScreenState extends State<ConnectionScreen> {
  Timer _timer;
  static Map<String, String> _connection = Map();

  @override
  void initState() {
    _getConnectionData();
    _timer = Timer.periodic(Duration(seconds: 2), (timer) {
      _getConnectionData();
    });
  }

  _getConnectionData() {
    setState(() {
      _connection = DeviceProvider.connectionData.toMap();
    });
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showContent() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: DisplayTable(
                labels: TableLabels.connection,
                data: _connection,
              ),
            )
          ],
        ));
  }

  Widget showBody() {
    return (_connection == null || _connection.length == 0) ? showProgress() : showContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: LeadingIconButton(
            Icons.wifi,
            tag: "connection",
          ),
          title: Text("Соединение"),
        ),
        body: showBody());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
