// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'exercises_cubit.dart';

@immutable
abstract class ExercisesState {}

class ExercisesInitialState extends ExercisesState {}

class ExercisesLoadingState extends ExercisesState {}

class ExercisesLoadedState extends ExercisesState {
  final List<ExerciseEntity> exercises;
  ExercisesLoadedState({required this.exercises});
}

class ExercisesErrorState extends ExercisesState {
  final String errorMessage;
  ExercisesErrorState({required this.errorMessage});
}
