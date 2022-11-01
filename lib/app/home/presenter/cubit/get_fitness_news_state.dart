part of 'get_fitness_news_cubit.dart';

@immutable
abstract class GetFitnessNewsState {}

class GetFitnessNewsInitial extends GetFitnessNewsState {}

class GetFitnessNewsLoading extends GetFitnessNewsState {}

class GetFitnessNewsLoaded extends GetFitnessNewsState {
  final List<FitnessNewsModel> fitnessNews;

  GetFitnessNewsLoaded({required this.fitnessNews});
}

class GetFitnessNewsError extends GetFitnessNewsState {
  final String erroMessage;

  GetFitnessNewsError({required this.erroMessage});
}
