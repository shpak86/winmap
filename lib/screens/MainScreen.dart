import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:winmap/components/MenuDrawer.dart';
import 'package:winmap/components/TileGrid.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Winmap"),
      ),
//      drawer: MenuDrawer(),
      body: TileGrid(),
    );
  }
}
