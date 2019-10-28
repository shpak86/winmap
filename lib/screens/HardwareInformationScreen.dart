import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/components/DisplayTable.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/components/TableLabels.dart';
import 'package:winmap/device/DeviceProvider.dart';

class HardwareInformationScreen extends StatelessWidget {
  final _properties = DeviceProvider.deviceData.toMap();

  Widget showContent() {
    return SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: DisplayTable(labels: TableLabels.hardware, data: _properties),
            )
          ],
        ));
  }

  Widget showProgress() {
    return CircularProgressIndicator();
  }

  Widget showBody() {
    return _properties == null ? showProgress() : showContent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.perm_device_information,
          tag: "hardware_information",
        ),
        title: Text("Device"),
      ),
      body: showBody(),
    );
  }
}
