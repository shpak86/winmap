import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'VerticalCaption.dart';

class RowCaptionContainer extends StatelessWidget {
  Widget _caption;
  Widget _child;
  Color _captionColor;

  RowCaptionContainer({Widget caption, Widget child, Color captionColor}) {
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          VerticalCaption(
            color: _captionColor,
            child: _caption,
          ),
          _child
        ],
      ),
    );
  }
}
