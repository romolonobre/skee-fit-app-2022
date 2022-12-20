// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skeefiapp/app/core/helper/helper.dart';

import '../../domain/models/exercises_model.dart';
import '../../services/get_all_exercises_service.dart';

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
      debuLog(e.toString());
      emit(GetAllExercisesErrorState(errorMessage: e.toString()));
    }
  }

  Future<void> filterExercises([String? exercisePart]) async {
    emit(GetAllExercisesLaodingState());
    final exercices = await service.getAllExerceses();

    try {
      final exerciesFiltered =
          exercices.where((element) => element.target.toLowerCase().contains(exercisePart ?? '')).toList();

      emit(FilterLoaded(exercises: exerciesFiltered));
    } catch (error) {
      emit(GetAllExercisesErrorState(errorMessage: error.toString()));
    }
  }
}
