// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';
import 'package:skeefiapp/app/exercises/repositories/exercises_repository.dart';

import '../../domain/entities/exercises_entity.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  final ExercisesRepository repository;
  ExercisesCubit(this.repository) : super(ExercisesInitialState());

  Future<void> getAllExercises() async {
    emit(ExercisesLoadingState());

    final response = await repository.getAll();

    if (response is Left) {
      emit(ExercisesErrorState(errorMessage: response.left.errorMessage));
    }

    emit(ExercisesLoadedState(exercises: response.right));
  }
}
