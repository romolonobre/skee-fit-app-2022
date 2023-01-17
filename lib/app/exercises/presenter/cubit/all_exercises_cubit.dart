// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

import '../../domain/models/exercises_model.dart';
import '../../services/get_all_exercises_service.dart';

part 'all_exercises_state.dart';

class GetAllExercisesCubit extends Cubit<GetAllExercisesState> {
  final GetAllExercisesServiceImpl service;
  GetAllExercisesCubit(
    this.service,
  ) : super(GetAllExercisesInitialState());

  Future<void> getAllExercises() async {
    emit(GetAllExercisesLaodingState());

    final response = await service.getAllExerceses();

    if (response is Right) {
      emit(AllExerciseLoadedState(exercises: response.right));
    }
    if (response is Left) {
      emit(AllExercisesErrorState(errorMessage: response.left.errorMessage));
    }
  }

  Future<void> filterExercises(String? exercisePart) async {
    emit(GetAllExercisesLaodingState());
    final exercices = await service.getAllExerceses();

    try {
      final exerciesFiltered =
          exercices.right.where((element) => element.target.toLowerCase().contains(exercisePart ?? '')).toList();

      emit(FilterLoaded(exercises: exerciesFiltered));
    } catch (error) {
      emit(AllExercisesErrorState(errorMessage: error.toString()));
    }
  }
}
