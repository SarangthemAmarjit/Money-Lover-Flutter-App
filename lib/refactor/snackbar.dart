import 'package:flutter/material.dart';

class CustomSnackBar {
  CustomSnackBar(BuildContext context, Widget content, Color bgcolor,
      {SnackBarAction? snackBarAction}) {
    final SnackBar snackBar = SnackBar(
        elevation: 30,
        action: snackBarAction,
        backgroundColor: bgcolor,
        content: content,
        behavior: SnackBarBehavior.floating);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
