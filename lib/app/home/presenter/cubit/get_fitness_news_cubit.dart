import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

import '../../domain/models/fitness_news_model.dart';
import '../../service/get_fitness_news_service.dart';

part 'get_fitness_news_state.dart';

class GetFitnessNewsCubit extends Cubit<FitnessNewsState> {
  final GetFitnessNewsService service;
  GetFitnessNewsCubit(this.service) : super(FitnessNewsInitial());

  Future<void> getFitnessNews() async {
    emit(FitnessNewsLoading());

    final response = await service.getFitnessNews();
    if (response is Left) {
      emit(GetFitnessNewsError(erroMessage: response.left.errorMessage));
    }
    if (response is Right) {
      emit(FitnessNewsLoaded(fitnessNews: response.right));
    }
  }
}
