import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/entities/exercises_entity.dart';

abstract class ExercisesRepository {
  Future<Either<Failure, List<ExerciseEntity>>> getAll();
}
