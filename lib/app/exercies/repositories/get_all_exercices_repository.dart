import 'dart:convert';

import 'package:skeefiapp/app/core/client/api_request.dart';

import '../../core/errors/failure.dart';
import '../domain/models/exercises_model.dart';

abstract class GetAllExercisesRepository {
  Future<List<ExercisesModel>> getAllExerceses();
}

class GetAllExercicesRepositoryImpl extends ApiRequest implements GetAllExercisesRepository {
  List<ExercisesModel> exerciseList = [];
  @override
  Future<List<ExercisesModel>> getAllExerceses() async {
    try {
      final response = await ApiRequest.get(
        ('https://exercisedb.p.rapidapi.com/exercises'),
        headers: {
          'X-RapidAPI-Key': 'f7e3fbf4cdmsh211a28a0f984a8cp1b4753jsnec5a014fed93',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        },
      );

      final jsonResponse = jsonDecode(response.body) as List;
      final exerciseList = jsonResponse.map<ExercisesModel>((e) => ExercisesModel.fromJson(e)).toList();

      return exerciseList;
    } on Exception catch (e, s) {
      throw Failure(exception: e, stackTrace: s);
    }
  }
}
