// ignore_for_file: unused_import

import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:http/http.dart' as http;
import 'package:skeefiapp/app/core/client/api_request.dart';
import 'package:skeefiapp/app/core/errors/error_handle.dart';
import 'package:skeefiapp/app/home/domain/errors/fitness_news_not_found_error.dart';

import '../../core/errors/failure.dart';
import '../domain/models/fitness_news_model.dart';

abstract class GetFitnessNewsRepository {
  Future<Either<Failure, List<FitnessNewsModel>>> getFitnessNews();
}

class GetFitnessNewsRepositoryImpl extends ApiRequest implements GetFitnessNewsRepository {
  @override
  Future<Either<Failure, List<FitnessNewsModel>>> getFitnessNews() async {
    try {
      final response = await ApiRequest.get(
        ('https://live-fitness-and-health-news.p.rapidapi.com/news'),
        headers: {
          'X-RapidAPI-Key': '1a4a290466msh7bd67dd12d9ce40p173e62jsnb7af6a3d8507',
          'X-RapidAPI-Host': 'live-fitness-and-health-news.p.rapidapi.com'
        },
      );

      final newsList = jsonDecode(response.body) as List;

      final news = newsList.map((e) => FitnessNewsModel.fromJson(e)).toList();

      if (response is Left) {
        return Left(FitnessNewsNotFoundError(errorMessage: "News not found"));
      }

      return Right(news);
    } on Failure catch (error, stackTrace) {
      ErrorHandle.externalErrorHandle(error.exception, stackTrace: stackTrace);
      return Left(FitnessNewsNotFoundError(errorMessage: error.toString()));
    } catch (error, stackTrace) {
      ErrorHandle.externalErrorHandle(error, stackTrace: stackTrace);
      return Left(FitnessNewsNotFoundError(errorMessage: 'Unknown error'));
    }
  }
}
