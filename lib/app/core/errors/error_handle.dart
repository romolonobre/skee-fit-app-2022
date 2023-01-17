import 'package:flutter/material.dart';

class ErrorHandle {
  static void externalErrorHandle(
    dynamic exeception, {
    StackTrace? stackTrace,
  }) {
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: exeception.toString());
    }
  }
}
