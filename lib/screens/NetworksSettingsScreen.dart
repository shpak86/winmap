import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/data/NetworksDisplaySettings.dart';

class NetworksDisplayPropertiesScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NetworksSettingsScreenState();
  }
}

class NetworksSettingsScreenState extends State<NetworksDisplayPropertiesScreen> {
  final ssidPatternController = TextEditingController();
  final bssidPatternController = TextEditingController();

  @override
  void initState() {
    super.initState();
    bssidPatternController.text = NetworksDisplaySettings.bssid;
    ssidPatternController.text = NetworksDisplaySettings.ssid;
    bssidPatternController.addListener(() {
      NetworksDisplaySettings.update(bssid: bssidPatternController.text);
    });
    ssidPatternController.addListener(() {
      NetworksDisplaySettings.update(ssid: ssidPatternController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filter"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              setState(() {
                NetworksDisplaySettings.setDefault();
                bssidPatternController.text = NetworksDisplaySettings.bssid;
                ssidPatternController.text = NetworksDisplaySettings.ssid;
              });
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListView(
                children: <Widget>[
                  networkFrequencySelector(),
                  networksOrderSelector(),
                  bssidPatternInput(),
                  ssidPatternInput()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  NetworksSortOrder stringToOrder(String string) {
    NetworksSortOrder result;
    if (string == "None") result = NetworksSortOrder.none;
    if (string == "BSSID ascending") result = NetworksSortOrder.bssidAsc;
    if (string == "BSSID descending") result = NetworksSortOrder.bssidDesc;
    if (string == "SSID ascending") result = NetworksSortOrder.ssidAsc;
    if (string == "SSID descending") result = NetworksSortOrder.ssidDesc;
    if (string == "Сигнал ascending") result = NetworksSortOrder.signalAsc;
    if (string == "Сигнал descending") result = NetworksSortOrder.signalDesc;
    return result;
  }

  String orderToString(NetworksSortOrder order) {
    String result = "";
    if (order == NetworksSortOrder.none) result = "None";
    if (order == NetworksSortOrder.bssidAsc) result = "BSSID ascending";
    if (order == NetworksSortOrder.bssidDesc) result = "BSSID descending";
    if (order == NetworksSortOrder.ssidAsc) result = "SSID ascending";
    if (order == NetworksSortOrder.ssidDesc) result = "SSID descending";
    if (order == NetworksSortOrder.signalAsc) result = "Сигнал ascending";
    if (order == NetworksSortOrder.signalDesc) result = "Сигнал descending";
    return result;
  }

  Widget networksOrderSelector() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Networks sort order",
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  value: orderToString(NetworksDisplaySettings.order),
                  onChanged: (String newValue) {
                    setState(() {
                      NetworksDisplaySettings.update(order: stringToOrder(newValue));
                    });
                  },
                  items: <String>[
                    "None",
                    "BSSID ascending",
                    "BSSID descending",
                    "SSID ascending",
                    "SSID descending",
                    "Сигнал ascending",
                    "Сигнал descending",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget bssidPatternInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "BSSID",
              alignLabelWithHint: true,
            ),
            controller: bssidPatternController,
          ),
        ),
      ],
    );
  }

  Widget ssidPatternInput() {
    return Row(
      children: <Widget>[
        Expanded(
          child: TextField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            maxLines: null,
            decoration: InputDecoration(
              labelText: "SSID",
              alignLabelWithHint: true,
            ),
            controller: ssidPatternController,
          ),
        ),
      ],
    );
  }

  NetworkFrequency stringToFrequency(String string) {
    NetworkFrequency frequency;
    if (string == "All") frequency = NetworkFrequency.all;
    if (string == "5 GHz networks") frequency = NetworkFrequency.mhz5000;
    if (string == "2.4 GHz networks") frequency = NetworkFrequency.mhz2400;
    return frequency;
  }

  String frequencyToString(NetworkFrequency frequency) {
    String result;
    if (frequency == NetworkFrequency.all) result = "All";
    if (frequency == NetworkFrequency.mhz5000) result = "5 GHz networks";
    if (frequency == NetworkFrequency.mhz2400) result = "2.4 GHz networks";
    return result;
  }

  Widget networkFrequencySelector() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Frequency",
            style: Theme.of(context).textTheme.caption,
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: DropdownButton<String>(
                  value: frequencyToString(NetworksDisplaySettings.frequency),
                  onChanged: (String newValue) {
                    setState(() {
                      NetworksDisplaySettings.update(frequency: stringToFrequency(newValue));
                    });
                  },
                  items: <String>[
                    "All",
                    "5 GHz networks",
                    "2.4 GHz networks",
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    bssidPatternController.dispose();
    ssidPatternController.dispose();
    super.dispose();
  }
}
