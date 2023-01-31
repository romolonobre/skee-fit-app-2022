import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/entities/exercises_entity.dart';

abstract class GetAllExercisesRepository {
  Future<Either<Failure, List<ExerciseEntity>>> getAllExerceses();
}
