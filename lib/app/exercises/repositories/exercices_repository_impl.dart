import 'package:either_dart/either.dart';

import '../../core/errors/error_handle.dart';
import '../../core/errors/failure.dart';
import '../datasource/exercise_datasource.dart';
import '../domain/entities/exercises_entity.dart';
import '../domain/errors/exercises_not_found_error.dart';
import '../domain/exercises_adapter.dart';
import 'exercises_repository.dart';

class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExercisesDataSource dataSource;

  ExercisesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, List<ExerciseEntity>>> getAll() async {
    try {
      final exercisesJson = await dataSource.getAllExercises();
      final exerciseList = exercisesJson.map<ExerciseEntity>((e) => ExercisesAdapter().fromJson(e)).toList();

      if (exerciseList.isEmpty) {
        return Left(ExercisesNotFoundError(errorMessage: "List of exercises is empty"));
      }

      return Right(exerciseList);
    } catch (e, s) {
      ErrorHandle.externalErrorHandle(e.toString(), stackTrace: s);
      return Left(ExercisesNotFoundError(errorMessage: e.toString(), stackTrace: s));
    }
  }
}
