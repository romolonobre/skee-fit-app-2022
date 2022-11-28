// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_bloc.dart';

@immutable
abstract class FilterState {}

class FilterInitial extends FilterState {}

class FilterLoaded extends FilterState {
  final List<ExercisesModel> exercises;
  FilterLoaded({required this.exercises});
}

class FilterLoading extends FilterState {}
