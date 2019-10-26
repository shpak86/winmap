import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StripedTable extends StatelessWidget {
  Map<String, String> _data;
  Map<String, String> _labels;
  Color _secondaryColor;
  Color _color = Colors.grey[100];

  StripedTable({Map<String, String> data, Map<String, String> labels = const {}, Color color, Color secondaryColor}) {
    this._data = data;
    this._labels = labels;
    this._color = color ?? Colors.blue[100];
    this._secondaryColor = secondaryColor;
  }

  @override
  Widget build(BuildContext context) {
    int index = 0;
    return Column(
      children: _labels.keys
          .map(
            (key) => Container(
              color: ++index % 2 != 0 ? _color : _secondaryColor,
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _labels[key] ?? "unknown",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Text(
                      _data.containsKey(key) ? (_data[key] ?? "unknown") : "unknown",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
