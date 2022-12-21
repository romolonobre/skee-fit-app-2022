import 'package:skeefiapp/app/core/errors/failure.dart';

class ChannelNotFoundError extends Failure {
  @override
  final String errorMessage;

  ChannelNotFoundError({required this.errorMessage});
}
