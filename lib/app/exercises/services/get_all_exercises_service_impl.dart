// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/models/exercises_model.dart';
import '../repositories/get_all_exercises_repository.dart';
import 'get_all_exercises_service.dart';

class GetAllExercisesServiceImpl extends GetAllExercisesService {
  final GetAllExercisesRepository repository;
  GetAllExercisesServiceImpl({required this.repository});
  @override
  Future<Either<Failure, List<ExercisesModel>>> getAllExerceses() async {
    final exercises = await repository.getAllExerceses();

    if (exercises is Left) {
      return Left(exercises.left);
    }
    return Right(exercises.right);
  }
}
