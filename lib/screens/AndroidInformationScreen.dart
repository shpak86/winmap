import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/components/DisplayTable.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/components/TableLabels.dart';
import 'package:winmap/device/DeviceProvider.dart';

class AndroidInformationScreen extends StatelessWidget {
  var _properties;

  AndroidInformationScreen() {
    _properties = DeviceProvider.deviceData.toMap();
  }

  Widget showContent() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(8.0),
      child: Center(
          child: DisplayTable(
        labels: TableLabels.android,
        data: _properties,
      )),
    );
  }

  Widget showProgress() {
    return Center(child: CircularProgressIndicator());
  }

  Widget showBody() {
    return _properties == null ? showProgress() : showContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.android,
          tag: "android_information",
        ),
        title: Text("Android"),
      ),
      body: showBody(),
    );
  }
}
