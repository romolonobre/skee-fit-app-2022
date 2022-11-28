// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:skeefiapp/app/exercies/domain/models/exercises_model.dart';

import '../../services/get_all_exercises_service.dart';

part 'filter_event.dart';
part 'filter_state.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  final GetAllExercisesServiceImpl service;
  FilterBloc(
    this.service,
  ) : super(FilterInitial()) {
    on<FilterEvent>((event, emit) {});
  }

  Future<List<ExercisesModel>> filterExercises(FilterExercises event, Emitter<FilterState> emit) async {
    final exercices = await service.getAllExerceses();

    final exerciesFiltered = exercices.where((element) => element.target == event.bodyTarget).toList();

    emit(FilterLoaded(exercises: exerciesFiltered));

    return exerciesFiltered;
  }
}



  // Future<List<ExercisesModel>> filterExercises(String exercisePart) async {
  //   final exercices = await service.getAllExerceses();

  //   final exerciesFiltered = exercices.where((element) => element.target == exercisePart).toList();
  //   print(exerciesFiltered);

  //   return exerciesFiltered;
  // }