import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'HorizontalCaption.dart';

class ColumnCaptionContainer extends StatelessWidget {
  Widget _caption;
  Widget _child;
  Color _captionColor;

  ColumnCaptionContainer({Widget caption, Widget child, Color captionColor}) {
    _caption = caption;
    _child = child;
    _captionColor = captionColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black38, blurRadius: 1, spreadRadius: 1)]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          HorizontalCaption(
            color: _captionColor,
            child: _caption,
          ),
          _child
        ],
      ),
    );
  }
}
