import 'package:flutter/cupertino.dart';

class HorizontalCaption extends StatelessWidget {
  Color _color;
  Widget _child;

  HorizontalCaption({Color color, Widget child}) {
    _color = color;
    _child = child;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(4), topRight: Radius.circular(4)),
        color: _color,
      ),
      child: Center(child: _child),
    );
  }
}
