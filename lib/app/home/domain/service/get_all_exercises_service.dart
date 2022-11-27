// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../models/exercises_model.dart';
import '../repositories/get_all_exercices_repository.dart';

abstract class GetAllExercisesService {
  Future<List<ExercisesModel>> getAllExerceses();
}

class GetAllExercisesServiceImpl extends GetAllExercisesService {
  final GetAllExercicesRepositoryImpl repository;
  GetAllExercisesServiceImpl({
    required this.repository,
  });
  @override
  Future<List<ExercisesModel>> getAllExerceses() async => await repository.getAllExerceses();
}
