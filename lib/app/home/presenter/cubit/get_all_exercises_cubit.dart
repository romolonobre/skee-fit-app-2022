// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/errors/failure.dart';
import '../../../exercies/domain/models/exercises_model.dart';
import '../../../exercies/services/get_all_exercises_service.dart';

part 'get_all_exercises_state.dart';

class GetAllExercisesCubit extends Cubit<GetAllExercisesState> {
  final GetAllExercisesServiceImpl service;
  GetAllExercisesCubit(
    this.service,
  ) : super(GetAllExercisesInitialState());

  Future<void> getAllExercises() async {
    try {
      emit(GetAllExercisesLaodingState());

      final exercises = await service.getAllExerceses();
      emit(GetAllExerciseLoadedState(exercises: exercises));
    } on Failure {
      emit(GetAllExercisesErrorState(
        errorMessage: 'sdsdsd',
      ));
    }
  }
}
