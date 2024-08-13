import 'dart:convert';
import 'dart:io';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:skeefiapp/app/core/client/api_request.dart';

abstract class ExercisesDataSource {
  Future<List<dynamic>> getAllExercises();
}

class ExercisesDataSourceImpl extends ApiRequest implements ExercisesDataSource {
  final String url = 'https://exercisedb.p.rapidapi.com/exercises';
  final String? _apiKey = dotenv.env['EXERCISE_API_KEY'];
  final String _apiHost = 'exercisedb.p.rapidapi.com';

  @override
  Future<List<dynamic>> getAllExercises() async {
    final response = await ApiRequest.get(
      url,
      headers: {
        'X-RapidAPI-Key': _apiKey!,
        'X-RapidAPI-Host': _apiHost,
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to fetch exercises');
    }

    return jsonDecode(response.body) as List<dynamic>;
  }
}
