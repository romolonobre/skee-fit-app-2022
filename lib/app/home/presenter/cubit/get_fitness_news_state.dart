part of 'get_fitness_news_cubit.dart';

@immutable
abstract class FitnessNewsState {}

class FitnessNewsInitial extends FitnessNewsState {}

class FitnessNewsLoading extends FitnessNewsState {}

class FitnessNewsLoaded extends FitnessNewsState {
  final List<FitnessNewsModel> fitnessNews;

  FitnessNewsLoaded({required this.fitnessNews});
}

class GetFitnessNewsError extends FitnessNewsState {
  final String erroMessage;

  GetFitnessNewsError({required this.erroMessage});
}
