import 'package:flutter/material.dart';

class ErrorHandle {
  static void externalErrorHandle(
    dynamic exeception, {
    String? tag,
    StackTrace? stackTrace,
  }) {
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: exeception.toString());
    }
  }
}
