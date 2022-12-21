import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:skeefiapp/app/core/client/api_request.dart';
import 'package:skeefiapp/app/exercies/domain/errors/exercises_not_found_error.dart';

import '../../core/errors/error_handle.dart';
import '../../core/errors/failure.dart';
import '../domain/models/exercises_model.dart';

abstract class GetAllExercisesRepository {
  Future<Either<Failure, List<ExercisesModel>>> getAllExerceses();
}

class GetAllExercicesRepositoryImpl extends ApiRequest implements GetAllExercisesRepository {
  List<ExercisesModel> exerciseList = [];
  @override
  Future<Either<Failure, List<ExercisesModel>>> getAllExerceses() async {
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

      if (exerciseList.isEmpty) {
        return Left(ExercisesNotFoundError(errorMessage: "List of exercises is empty"));
      }

      if (response is Left) {
        return Left(ExercisesNotFoundError(errorMessage: "Exercise not found "));
      }

      return Right(exerciseList);
    } on Failure catch (e, s) {
      ErrorHandle.externalErrorHandle(e.toString(), stackTrace: s);
      return Left(ExercisesNotFoundError(errorMessage: e.toString(), stackTrace: s));
    } catch (error, stackTrace) {
      ErrorHandle.externalErrorHandle(error, stackTrace: stackTrace);
      return Left(ExercisesNotFoundError(errorMessage: 'Unknown error'));
    }
  }
}
