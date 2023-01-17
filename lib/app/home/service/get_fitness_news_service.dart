import 'package:either_dart/either.dart';

import '../../core/errors/failure.dart';
import '../domain/models/fitness_news_model.dart';
import '../repositories/get_fitness_news_repository.dart';

abstract class GetFitnessNewsService {
  Future<Either<Failure, List<FitnessNewsModel>>> getFitnessNews();
}

class GetFitnessNewsServiceImpl implements GetFitnessNewsService {
  final GetFitnessNewsRepository repository;

  GetFitnessNewsServiceImpl({required this.repository});
  @override
  Future<Either<Failure, List<FitnessNewsModel>>> getFitnessNews() async {
    final response = await repository.getFitnessNews();
    if (response is Left) {
      return Left(response.left);
    }

    return Right(response.right);
  }
}
