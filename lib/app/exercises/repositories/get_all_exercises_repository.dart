import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/models/exercises_model.dart';

abstract class GetAllExercisesRepository {
  Future<Either<Failure, List<ExercisesModel>>> getAllExerceses();
}
