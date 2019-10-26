import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/data/SpeedMeasuremet.dart';

class BarList extends StatefulWidget {
  List<SpeedMeasurement> items;

  BarList({Key key, this.items}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return BarListState();
  }
}

class BarListState extends State<BarList> {
  @override
  Widget build(BuildContext context) {
    double maxValue = 0;
    widget.items.forEach((item) {
      maxValue = max(maxValue, double.parse(item.value));
    });
    return ListView.builder(
      padding: EdgeInsets.all(8),
      itemCount: widget.items.length,
      itemBuilder: (context, index) {
        var item = widget.items[index];
        var color = item.type == "download" ? Colors.cyan : Colors.purple;
        var width = 0.7 * MediaQuery.of(context).size.width * (double.parse(item.value) / maxValue);
        var time = item.time;
        String caption = item.value + "Mbit/s";
        return Row(
          children: <Widget>[
            Text(time),
            Container(
              padding: EdgeInsets.all(2),
              alignment: Alignment.centerRight,
              margin: EdgeInsets.all(4),
              color: color,
              width: width,
              height: 20,
              child: Text(caption),
//              duration: Duration(milliseconds: 100),
            )
          ],
        );
      },
    );
  }
}
