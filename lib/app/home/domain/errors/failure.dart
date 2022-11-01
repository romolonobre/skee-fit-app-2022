// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class IFailure implements Exception {
  final String message;

  IFailure({
    StackTrace? stackTrace,
    dynamic exception,
    required this.message,
  });
}

class Failure extends IFailure {
  @override
  String message;
  dynamic exception;
  StackTrace? stackTrace;
  Failure({this.message = 'Unkwon message', this.stackTrace, this.exception})
      : super(message: message, stackTrace: stackTrace, exception: exception);
}
