import 'package:flutter/material.dart';
import 'package:local_note/utils/color_util.dart';

void showSnackBar(ScaffoldState scaffoldState, String message) {
  scaffoldState.showSnackBar(SnackBar(
      backgroundColor: colorPrimary,
      content: Text(
        message,
        style: TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
      )));
}
