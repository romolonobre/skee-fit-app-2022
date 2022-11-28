// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'filter_bloc.dart';

@immutable
abstract class FilterEvent {}

class FilterExercises extends FilterEvent {
  final String bodyTarget;
  FilterExercises({
    required this.bodyTarget,
  });
}
