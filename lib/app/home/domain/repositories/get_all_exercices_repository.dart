import 'dart:convert';

import 'package:http/http.dart' as http;

import '../errors/failure.dart';
import '../models/exercises_model.dart';

abstract class GetAllExercisesRepository {
  Future<List<ExercisesModel>> getAllExerceses();
}

class GetAllExercicesRepositoryImpl implements GetAllExercisesRepository {
  List<ExercisesModel> exerciseList = [];
  @override
  Future<List<ExercisesModel>> getAllExerceses() async {
    try {
      final response = await http.get(
        Uri.parse('https://exercisedb.p.rapidapi.com/exercises'),
        headers: {
          'X-RapidAPI-Key': '1a4a290466msh7bd67dd12d9ce40p173e62jsnb7af6a3d8507',
          'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com'
        },
      );

      final jsonResponse = jsonDecode(response.body) as List;
      final exerciseList = jsonResponse.map((e) => ExercisesModel.fromJson(e)).toList();

      return exerciseList;
    } on Exception catch (e, s) {
      throw Failure(exception: e, stackTrace: s);
    }
  }
}
