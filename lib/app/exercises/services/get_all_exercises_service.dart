import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/entities/exercises_entity.dart';

abstract class GetAllExercisesService {
  Future<Either<Failure, List<ExerciseEntity>>> getAllExercises();
}
