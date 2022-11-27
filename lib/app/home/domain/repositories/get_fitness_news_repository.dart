// ignore_for_file: unused_import

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:skeefiapp/app/core/client/api_request.dart';

import '../errors/failure.dart';
import '../models/fitness_news_model.dart';

abstract class GetFitnessNewsRepository {
  Future<List<FitnessNewsModel>> getFitnessNews();
}

class GetFitnessNewsRepositoryImpl extends ApiRequest implements GetFitnessNewsRepository {
  @override
  Future<List<FitnessNewsModel>> getFitnessNews() async {
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

      return news;
    } on IFailure catch (e, stackTrace) {
      throw (Failure(message: e.toString(), stackTrace: stackTrace));
    }
  }
}
