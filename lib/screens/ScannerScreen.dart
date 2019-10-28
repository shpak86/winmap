import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tcp_scanner/tcp_scanner.dart';
import 'package:winmap/Scanner.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScannerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ScannerScreenState();
  }
}

class ScannerScreenState extends State<ScannerScreen> {
  final _hostController = TextEditingController();
  final _startPortController = TextEditingController();
  final _endPortController = TextEditingController();
  final String HOST_KEY = "scan.host";
  final String START_PORT_KEY = "scan.start.port";
  final String END_PORT_KEY = "scan.end.port";
  Timer _timer;
  int eye = 0;
  SharedPreferences _preferences;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((preferences) {
      setState(() {
        _preferences = preferences;
        _hostController.text = _preferences.containsKey(HOST_KEY) ? _preferences.getString(HOST_KEY) : "";
        _startPortController.text = _preferences.containsKey(START_PORT_KEY) ? _preferences.getString(START_PORT_KEY) : "";
        _endPortController.text = _preferences.containsKey(END_PORT_KEY) ? _preferences.getString(END_PORT_KEY) : "";
      });
    });

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  showScanEditor() {
    return ListView(
      padding: EdgeInsets.all(8),
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                keyboardType: TextInputType.url,
                controller: _hostController,
                decoration: InputDecoration(labelText: "Host",),
              ),
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _startPortController,
                  decoration: InputDecoration(labelText: "Start port"),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _endPortController,
                  decoration: InputDecoration(labelText: "End port"),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  showScanReport() {
    return GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: Scanner.result.open.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 8),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(color: Colors.green, borderRadius: BorderRadius.all(Radius.circular(2)),),
            margin: EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(Scanner.result.open[index].toString()),
              ],
            ),
          );
        });
  }

  showContent() {
    return Scanner.status == ScanStatuses.unknown ? showScanEditor() : showScanReport();
  }

  showFloatingActionButton() {
    var result;
    if (Scanner.status == ScanStatuses.unknown) {
      result = FloatingActionButton(
        child: Icon(Icons.send),
        onPressed: () async {
          _preferences.setString(HOST_KEY, _hostController.text);
          _preferences.setString(START_PORT_KEY, _startPortController.text);
          _preferences.setString(END_PORT_KEY, _endPortController.text);

          setState(() {
            Scanner.scan(_hostController.text, _startPortController.text, _endPortController.text);
          });
        },
      );
    } else if (Scanner.status == ScanStatuses.scanning) {
      result = FloatingActionButton.extended(onPressed: null, label: Text(Scanner.percent.toStringAsPrecision(3) + "%"));
    } else {
      result = FloatingActionButton(
          backgroundColor: ThemeData.dark().errorColor,
          child: Icon(Icons.delete),
          onPressed: () {
            setState(() {
              Scanner.clear();
            });
          });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.import_export,
          tag: "scanner",
        ),
        title: Text("TCP scanner"),
      ),
      body: showContent(),
      floatingActionButton: showFloatingActionButton(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
