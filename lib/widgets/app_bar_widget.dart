import 'package:flutter/material.dart';
import 'package:local_note/utils/color_util.dart';

class AppBarWidget extends AppBar {
  final String text;

  AppBarWidget({Key key, this.text})
      : super(
            key: key,
            backgroundColor: colorBackground,
            elevation: 0,
            centerTitle: true,
            title: Text(
              text,
              style: TextStyle(color: colorPrimary, fontSize: 24),
            ));
}
