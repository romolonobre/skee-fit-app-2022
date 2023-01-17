import 'package:skeefiapp/app/core/errors/failure.dart';

class ExercisesNotFoundError extends Failure {
  ExercisesNotFoundError({
    StackTrace? stackTrace,
    dynamic exeception,
    required String errorMessage,
  }) : super(
          stackTrace: stackTrace,
          exception: exeception,
          errorMessage: errorMessage,
        );
}
