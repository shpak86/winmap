import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/AuthorizationProvider.dart';
import 'package:winmap/ReportProvider.dart';
import 'package:winmap/SpeedometerProvider.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/data/Account.dart';
import 'package:winmap/data/Report.dart';
import 'package:winmap/data/TestsData.dart';
import 'package:winmap/device/DeviceProvider.dart';

import '../Scanner.dart';

class ReportScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportScreenState();
  }
}

class ReportScreenState extends State<ReportScreen> {
  Map<String, bool> flags = {
    "connection": false,
    "device": false,
    "networks": false,
    "tests": false
  };

  final _commentTextFieldController = TextEditingController();
  bool _authorized = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      _authorized = AuthorizationProvider.authorized;
      ;
    });

    setState(() {
      flags = {
        "connection": DeviceProvider.connectionData != null,
        "device": DeviceProvider.deviceData != null,
        "networks": DeviceProvider.networks.length > 0,
        "tests": DeviceProvider.testsData != null,
      };
    });
  }

  @override
  void dispose() {
    _commentTextFieldController.dispose();
    super.dispose();
  }

  void sendReport({String url = "https://94.103.91.144/rest/measurements/"}) {
    var sender = ReportProvider(url: url);
    var report = Report(account: Account(AuthorizationProvider.email, AuthorizationProvider.password), device: DeviceProvider.deviceData, networks: DeviceProvider.networks, connection: DeviceProvider.connectionData, tests: TestsData(SpeedometerProvider.barList, Scanner.result.open), comment: _commentTextFieldController.text);
    sender.send(report: report).then((response) {
      try {
        Map<String, dynamic> data = jsonDecode(response);
        showResponse(response: {
          "id": data.containsKey("value") ? data["value"].toString() : "unknown"
        });
      } catch (e) {
        print(e);
      }
    });
  }

  Future<void> showResponse({Map<String, String> response}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Report sent"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Report number: " + (response != null ? response["id"] : "unknown")),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.assignment_turned_in,
          tag: "report",
        ),
        title: Text("Send report"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Device informaton"),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: flags["device"]
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Connection"),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: flags["connection"]
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Networks"),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: flags["networks"]
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Text("Tests"),
                  flex: 3,
                ),
                Expanded(
                  flex: 1,
                  child: flags["tests"]
                      ? Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.clear,
                          color: Colors.red,
                        ),
                ),
              ],
            ),
            Expanded(
              child: TextField(
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                maxLines: null,
                decoration: InputDecoration(
                  labelText: "Comment",
                  alignLabelWithHint: true,
                ),
                controller: _commentTextFieldController,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.send),
        backgroundColor: _authorized ? Colors.tealAccent : Colors.grey,
        onPressed: _authorized
            ? () {
//          sendReport();
                sendReport(url: "https://94.103.91.144/rest/measurements/");
              }
            : null,
      ),
    );
  }
}
