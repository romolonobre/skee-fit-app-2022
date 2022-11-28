// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../exercies/domain/models/exercises_model.dart';
import '../../../exercies/services/get_all_exercises_service.dart';

part 'get_all_exercises_state.dart';

class GetAllExercisesCubit extends Cubit<GetAllExercisesState> {
  final GetAllExercisesServiceImpl service;
  GetAllExercisesCubit(
    this.service,
  ) : super(GetAllExercisesInitialState());

  Future<void> getAllExercises() async {
    emit(GetAllExercisesLaodingState());
    try {
      final exercises = await service.getAllExerceses();
      emit(GetAllExerciseLoadedState(exercises: exercises));
    } catch (e) {
      emit(GetAllExercisesErrorState(
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> filterExercises([String? exercisePart]) async {
    final exercices = await service.getAllExerceses();

    try {
      final exerciesFiltered =
          exercices.where((element) => element.target.toLowerCase().contains(exercisePart ?? '')).toList();

      emit(FilterLoaded(exercises: exerciesFiltered));
    } on Exception catch (error) {
      emit(GetAllExercisesErrorState(errorMessage: error.toString()));
    }
  }
}
