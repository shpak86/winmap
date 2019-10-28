import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          DrawerHeader(
            child: Text('WIreless Network Mapper'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.perm_device_information),
            title: Text("Device"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/device");
            },
          ),
          ListTile(
            leading: Icon(Icons.leak_add),
            title: Text("Connection"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/connection");
            },
          ),
          ListTile(
            leading: Icon(Icons.wifi),
            title: Text("Wi-Fi networks"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/networks");
            },
          ),
          ListTile(
            leading: Icon(Icons.build),
            title: Text("Tools"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/tools");
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("Send report"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/report");
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text("View report"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/report_viewer");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, "/configuration");
            },
          ),
        ],
      ),
    );
  }
}
