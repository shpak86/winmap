import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/ReportProvider.dart';
import 'package:winmap/components/DisplayTable.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/components/NetworkCard.dart';
import 'package:winmap/components/TableLabels.dart';
import 'package:winmap/data/ConnectionData.dart';
import 'package:winmap/data/Report.dart';

class ReportViewerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ReportViewerScreenState();
  }
}

class ReportViewerScreenState extends State<ReportViewerScreen> {
  Report _report;
  List<Widget> _networkCards;
  Widget _connectionCard;
  Widget _hardwareCard;
  Widget _androidCard;
  String _reportId = "";

  var reportEditController = TextEditingController();

  Widget connectionContainer(ConnectionData data) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Connection",
              style: TextStyle(fontSize: 24),
            ),
          ),
          DisplayTable(
            labels: TableLabels.connection,
            data: data.toMap(),
          )
        ],
      ),
    );
  }

  Widget hardwareContainer(Map data) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Device",
              style: TextStyle(fontSize: 24),
            ),
          ),
          DisplayTable(
            labels: TableLabels.hardware,
            data: data,
          )
        ],
      ),
    );
  }

  Widget androidContainer(Map data) {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Android",
              style: TextStyle(fontSize: 24),
            ),
          ),
          DisplayTable(
            labels: TableLabels.android,
            data: data,
          )
        ],
      ),
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  networksLabel() {
    return Container(
      padding: EdgeInsets.only(top: 16),
      child: Column(
        children: <Widget>[
          Center(
            child: Text(
              "Networks",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ],
      ),
    );
  }

  Widget showContent() {
    var children = <Widget>[]
      ..add(_hardwareCard)
      ..add(_androidCard)
      ..add(_connectionCard)
      ..add(networksLabel())
      ..addAll(_networkCards);
    return ListView(
      children: children,
    );
  }

  Widget showBody() {
    if (_reportId.isEmpty) {
      return Center(
        child:
//        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 150),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: reportEditController,
                    decoration: InputDecoration(
                      labelText: "Report number",
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  setState(() {
                    _reportId = reportEditController.text;
                  });
                  ReportProvider reportProvider = ReportProvider(url: "https://94.103.91.144/rest/measurements/");
                  reportProvider.load(id: _reportId).then((report) {
                    var device = report.device.toMap();
                    setState(() {
                      _report = report;
                      _networkCards = _report.networks.map((network) => NetworkCard(network)).toList();
                      _connectionCard = connectionContainer(_report.connection);
                      _hardwareCard = hardwareContainer(device);
                      _androidCard = androidContainer(device);
                    });
                  });
                },
              )
            ],
          ),
//        ],
      );
    } else {
      return _report == null ? showProgress() : showContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.assignment_returned,
          tag: "report_viewer",
        ),
        title: Text("View report"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                _report = null;
                _reportId = "";
                reportEditController.text = "";
              });
            },
          )
        ],
      ),
      body: showBody(),
    );
  }
}
