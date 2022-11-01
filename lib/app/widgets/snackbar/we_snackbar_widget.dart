import 'package:flutter/material.dart';

enum SnackBarStatus {
  error,
  success,
  notification,
}

Future<void> showSnackbar(BuildContext context, String message, SnackBarStatus status) async {
  late MaterialColor color;

  if (status == SnackBarStatus.success) {
    color = Colors.green;
  }
  if (status == SnackBarStatus.error) {
    color = Colors.red;
  }
  if (status == SnackBarStatus.notification) {
    color = Colors.blue;
  }

  ScaffoldMessenger.of(context).hideCurrentSnackBar();
  final snackBar = SnackBar(
    backgroundColor: color[100],
    elevation: 5,
    content: Container(
      child: Text(
        message,
        style: TextStyle(
          color: color[900],
          fontSize: 15,
        ),
      ),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
