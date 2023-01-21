// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

import '../../domain/models/exercises_model.dart';
import '../../services/get_all_exercises_service_impl.dart';

part 'all_exercises_state.dart';

class GetAllExercisesCubit extends Cubit<GetAllExercisesState> {
  final GetAllExercisesServiceImpl service;
  GetAllExercisesCubit(
    this.service,
  ) : super(GetAllExercisesInitialState());

  // Method to get all Exercises
  //
  Future<void> getAllExercises() async {
    emit(GetAllExercisesLaodingState());

    final response = await service.getAllExercises();

    if (response is Left) {
      emit(AllExercisesErrorState(errorMessage: response.left.errorMessage));
    }

    emit(AllExerciseLoadedState(exercises: response.right));
  }

  // Method to search exercises by body target
  //
  Future<void> filterExercises(String? exercisePart) async {
    emit(GetAllExercisesLaodingState());

    final response = await service.getAllExercises();

    if (response is Left) {
      emit(AllExercisesErrorState(errorMessage: response.left.errorMessage));
    }
    final exerciesFiltered =
        response.right.where((element) => element.target.toLowerCase().contains(exercisePart ?? '')).toList();

    emit(FilterLoaded(exercises: exerciesFiltered));
  }
}
