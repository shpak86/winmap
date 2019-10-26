import 'package:flutter/material.dart';

class ScreenTile extends StatelessWidget {
  IconData _iconData;
  String _label;
  String _route;
  Color _iconColor;
  Color _color;
  String _tag;

  ScreenTile({IconData icon, String label = "", String route = "", Color iconColor = Colors.white, Color color = Colors.white10, String tag}) {
    _iconData = icon;
    _label = label;
    _route = route;
    _iconColor = iconColor;
    _color = color;
    _tag = tag;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.cyan,
      onTap: () {
        Navigator.pushNamed(context, _route);
      },
      child: Container(
        decoration: BoxDecoration(
          color: _color,
          borderRadius: BorderRadius.all(Radius.circular(2)),
//          boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 1)]
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: _tag != null
                  ? Hero(
                      tag: _tag,
                      child: Icon(
                        _iconData,
                        size: 50,
                        color: _iconColor,
                      ),
                    )
                  : Icon(
                      _iconData,
                      size: 50,
                      color: _iconColor,
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text(_label),
            ),
          ],
        ),
      ),
    );
  }
}
