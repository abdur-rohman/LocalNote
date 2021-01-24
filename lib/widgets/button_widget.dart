import 'package:flutter/material.dart';
import 'package:local_note/utils/color_util.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function onClick;
  final Color color;

  const ButtonWidget(
      {Key key, @required this.text, @required this.onClick, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color: color ?? colorAccent,
        padding: EdgeInsets.all(16),
        child: Text(
          text,
          style: TextStyle(
              color: colorPrimary, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        onPressed: onClick);
  }
}
