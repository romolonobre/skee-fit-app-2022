import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../domain/models/fitness_news_model.dart';
import '../../domain/service/get_fitness_news_service.dart';

part 'get_fitness_news_state.dart';

class GetFitnessNewsCubit extends Cubit<GetFitnessNewsState> {
  final GetFitnessNewsService service;
  GetFitnessNewsCubit(this.service) : super(GetFitnessNewsInitial());

  Future<void> getFitnessNews() async {
    emit(GetFitnessNewsLoading());
    try {
      final response = await service.getFitnessNews();

      emit(GetFitnessNewsLoaded(fitnessNews: response));
    } catch (e) {
      emit(GetFitnessNewsError(erroMessage: 'Failed to Load news '));
    }
  }
}
