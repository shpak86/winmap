import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:winmap/components/DisplayTable.dart';
import 'package:winmap/data/NetworkData.dart';

class NetworkCard extends StatefulWidget {
  NetworkData _network;
  Map<String, String> _netMap;
  Color _primaryTableColor;
  Color _secondaryTableColor;
  Color _containerColor;
  String _networkType;

  NetworkCard(this._network, {Color containerColor, Color primaryTableColor, Color secondaryTableColor}) : super(key: ValueKey(_network.bssid)) {
    _netMap = _network.toMap();
    _networkType = _network.frequency.startsWith("2") ? "2.4" : "5";
    if (primaryTableColor == null) {
      _primaryTableColor = _networkType == "5" ? Colors.teal : Colors.deepPurple;
    } else {
      _primaryTableColor = primaryTableColor;
    }
    if (secondaryTableColor == null) {
      _secondaryTableColor = Colors.white;
    } else {
      _secondaryTableColor = secondaryTableColor;
    }
    if (containerColor == null) {
      _containerColor = _networkType == "5" ? Colors.white30 : Colors.white10;
    } else {
      _containerColor = containerColor;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return NetworkCardState(_netMap, _primaryTableColor, _secondaryTableColor, _containerColor, _networkType);
  }
}

class NetworkCardState extends State<NetworkCard> {
  static const _labels = {
    "ssid": "SSID",
    "bssid": "BSSID",
    "capabilities": "Capabilities",
    "centerFreq0": "Center 0",
    "centerFreq1": "Center 1",
    "channelWidth": "Width",
    "frequency": "Frequency",
    "level": "Signal"
  };

  Map<String, String> _netMap;
  Color _primaryTableColor;
  Color _secondaryTableColor;
  Color _containerColor;
  String _networkType;
  bool showActions = false;
  bool watching = false;

  NetworkCardState(this._netMap, this._primaryTableColor, this._secondaryTableColor, this._containerColor, this._networkType);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        setState(() {
          Clipboard.setData(ClipboardData(text: _netMap.toString()));
          showToast();
        });
      },
      child: Container(
        margin: EdgeInsets.all(4),
        decoration: BoxDecoration(color: _containerColor, borderRadius: BorderRadius.all(Radius.circular(4.0)), boxShadow: [
          BoxShadow(color: Colors.black54, blurRadius: 2)
        ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(8),
              child: CircleAvatar(
                child: Text(
                  _networkType,
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: _primaryTableColor,
              ),
            ),
            Expanded(
                child: DisplayTable(
              labels: _labels,
              data: _netMap,
            )

                /*StripedTable(
                color: _primaryTableColor,
                secondaryColor: _secondaryTableColor,
                data: _netMap,
                labels: _labels,

               */
//              ),
                ),
          ],
        ),
      ),
    );
  }

  showToast() {
    final scaffold = Scaffold.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Copied to clipboard'),
        action: SnackBarAction(label: 'OK', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }
}
