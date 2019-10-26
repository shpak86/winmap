import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/components/LeadingIconButton.dart';
import 'package:winmap/components/NetworkCard.dart';
import 'package:winmap/data/NetworkData.dart';
import 'package:winmap/data/NetworksDisplaySettings.dart';
import 'package:winmap/device/DeviceProvider.dart';

class NetworksScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NetworksScreenState();
  }
}

class NetworksScreenState extends State<NetworksScreen> {
  List<NetworkData> _networks = [];
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _getNetworks();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) => _getNetworks());
  }

  _getNetworks() {
    setState(() {
      _networks.clear();
      _networks.addAll(NetworksDisplaySettings.filter(DeviceProvider.networks).toList());
    });
  }

  Widget showContent() {
    return ListView.builder(
      itemCount: _networks.length,
      itemBuilder: (BuildContext context, int index) {
        return NetworkCard(_networks[index]);
      },
    );
  }

  Widget showProgress() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showBody() {
    if (_networks == null || _networks.isEmpty) {
      return showProgress();
    } else {
      return showContent();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: LeadingIconButton(
          Icons.leak_add,
          tag: "networks",
        ),
        title: Text("Wi-Fi сети"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
              color: NetworksDisplaySettings.isDefault() ? null : Colors.redAccent,
            ),
            onPressed: () {
              Navigator.pushNamed(context, "/networks_display_properties");
            },
          ),
        ],
      ),
      body: showBody(),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
