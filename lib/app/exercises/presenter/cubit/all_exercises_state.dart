// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'all_exercises_cubit.dart';

@immutable
abstract class GetAllExercisesState {}

class GetAllExercisesInitialState extends GetAllExercisesState {}

class GetAllExercisesLaodingState extends GetAllExercisesState {}

class AllExerciseLoadedState extends GetAllExercisesState {
  List<ExerciseEntity> exercises;
  AllExerciseLoadedState({
    required this.exercises,
  });
}

class AllExercisesErrorState extends GetAllExercisesState {
  final String errorMessage;
  AllExercisesErrorState({required this.errorMessage});
}

class FilterLoaded extends GetAllExercisesState {
  final List<ExerciseEntity> exercises;
  FilterLoaded({required this.exercises});
}
