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
        title: Text("Фильтр списка"),
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
    if (string == "Без сортировки") result = NetworksSortOrder.none;
    if (string == "BSSID по возрастанию") result = NetworksSortOrder.bssidAsc;
    if (string == "BSSID по убыванию") result = NetworksSortOrder.bssidDesc;
    if (string == "SSID по возрастанию") result = NetworksSortOrder.ssidAsc;
    if (string == "SSID по убыванию") result = NetworksSortOrder.ssidDesc;
    if (string == "Сигнал по возрастанию") result = NetworksSortOrder.signalAsc;
    if (string == "Сигнал по убыванию") result = NetworksSortOrder.signalDesc;
    return result;
  }

  String orderToString(NetworksSortOrder order) {
    String result = "";
    if (order == NetworksSortOrder.none) result = "Без сортировки";
    if (order == NetworksSortOrder.bssidAsc) result = "BSSID по возрастанию";
    if (order == NetworksSortOrder.bssidDesc) result = "BSSID по убыванию";
    if (order == NetworksSortOrder.ssidAsc) result = "SSID по возрастанию";
    if (order == NetworksSortOrder.ssidDesc) result = "SSID по убыванию";
    if (order == NetworksSortOrder.signalAsc) result = "Сигнал по возрастанию";
    if (order == NetworksSortOrder.signalDesc) result = "Сигнал по убыванию";
    return result;
  }

  Widget networksOrderSelector() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Порядок сортировки сетей",
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
                    "Без сортировки",
                    "BSSID по возрастанию",
                    "BSSID по убыванию",
                    "SSID по возрастанию",
                    "SSID по убыванию",
                    "Сигнал по возрастанию",
                    "Сигнал по убыванию",
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
    if (string == "Все сети") frequency = NetworkFrequency.all;
    if (string == "Сети 5 GHz") frequency = NetworkFrequency.mhz5000;
    if (string == "Сети 2.4 GHz") frequency = NetworkFrequency.mhz2400;
    return frequency;
  }

  String frequencyToString(NetworkFrequency frequency) {
    String result;
    if (frequency == NetworkFrequency.all) result = "Все сети";
    if (frequency == NetworkFrequency.mhz5000) result = "Сети 5 GHz";
    if (frequency == NetworkFrequency.mhz2400) result = "Сети 2.4 GHz";
    return result;
  }

  Widget networkFrequencySelector() {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Частоты",
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
                    "Все сети",
                    "Сети 5 GHz",
                    "Сети 2.4 GHz",
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
