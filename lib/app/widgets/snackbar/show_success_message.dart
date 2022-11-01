import 'package:flutter/material.dart';

import 'we_snackbar_widget.dart';

class ShowSuccessMessage {
  void call(String message, {required BuildContext context}) {
    showSnackbar(
      context,
      message,
      SnackBarStatus.success,
    );
  }
}
