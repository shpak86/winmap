import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LeadingIconButton extends StatelessWidget {
  IconData _iconData;
  String _tag;
  Color _color;

  LeadingIconButton(this._iconData, {String tag, Color color}) {
    _tag = tag;
    _color = color;
  }

  _getHeroIcon() {
    Widget result;
    if (_tag != null) {
      result = Hero(
        tag: _tag,
        child: Icon(
          _iconData,
          color: _color,
          size: 24,
        ),
      );
    } else {
      result = Icon(
        _iconData,
        color: _color,
        size: 24,
      );
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 16),
        child: Row(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(left: 8),
              child: Icon(Icons.arrow_back),
            ),
            _getHeroIcon(),
          ],
        ),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }
}
