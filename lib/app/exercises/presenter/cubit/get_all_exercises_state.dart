// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'get_all_exercises_cubit.dart';

@immutable
abstract class GetAllExercisesState {}

class GetAllExercisesInitialState extends GetAllExercisesState {}

class GetAllExercisesLaodingState extends GetAllExercisesState {}

class GetAllExerciseLoadedState extends GetAllExercisesState {
  List<ExercisesModel> exercises;
  GetAllExerciseLoadedState({
    required this.exercises,
  });
}

class GetAllExercisesErrorState extends GetAllExercisesState {
  final String errorMessage;
  GetAllExercisesErrorState({required this.errorMessage});
}

class FilterLoaded extends GetAllExercisesState {
  final List<ExercisesModel> exercises;
  FilterLoaded({required this.exercises});
}
