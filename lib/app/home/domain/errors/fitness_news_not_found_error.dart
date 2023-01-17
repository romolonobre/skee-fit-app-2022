// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:skeefiapp/app/core/errors/failure.dart';

class FitnessNewsNotFoundError extends Failure {
  @override
  final String errorMessage;
  FitnessNewsNotFoundError({
    required this.errorMessage,
  }) : super(errorMessage: errorMessage);
}
