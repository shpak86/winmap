import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/SpeedometerProvider.dart';
import 'package:winmap/components/BarList.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/data/SpeedMeasuremet.dart';

class SpeedometerScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SpeedometerScreenState();
  }
}

class SpeedometerScreenState extends State<SpeedometerScreen> {
  List<SpeedMeasurement> _items = [];
  Timer _timer;

  @override
  void initState() {
    super.initState();
    setState(() {
      _items = SpeedometerProvider.barList;
    });
  }

  _showContent() {
    return BarList(
      items: _items,
    );
  }

  _startTesting() {
    SpeedometerProvider.start();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _items = SpeedometerProvider.barList;
      });
    });
  }

  _stopTesting() {
    SpeedometerProvider.stop();
  }

  _showFloatingActionButton() {
    var result = FloatingActionButton(
        child: Icon(Icons.network_check),
        onPressed: () {
          _startTesting();
        });
    if (SpeedometerProvider.isActive)
      return FloatingActionButton(
          backgroundColor: Colors.red,
          child: Icon(Icons.clear),
          onPressed: () {
            _stopTesting();
          });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.network_check,
          tag: "speedometer",
        ),
        title: Text("Speed test"),
      ),
      body: _showContent(),
      floatingActionButton: _showFloatingActionButton(),
    );
  }

  @override
  void dispose() {
    if (_timer != null) _timer.cancel();
    super.dispose();
  }
}
