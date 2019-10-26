import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayTable extends StatelessWidget {
  Map<String, String> _labels;
  Map<String, String> _data;

  DisplayTable({Key key, Map<String, String> labels, Map<String, String> data}) : super(key: key) {
    _labels = labels;
    _data = data;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: DataTable(
                columns: [
                  DataColumn(label: Text("Параметр")),
                  DataColumn(label: Text("Значение"))
                ],
                rows: _labels.keys
                    .map((label) => DataRow(cells: [
                          DataCell(Text(label),),
                          DataCell(_data.containsKey(label) ? SelectableText(_data[label] ?? "") : Text("undefined"))
                        ]))
                    .toList(),
              ),
            )
          ],
        ));
  }
}
