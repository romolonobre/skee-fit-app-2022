import '../models/fitness_news_model.dart';
import '../repositories/get_fitness_news_repository.dart';

abstract class GetFitnessNewsService {
  Future<List<FitnessNewsModel>> getFitnessNews();
}

class GetFitnessNewsServiceImpl implements GetFitnessNewsService {
  final GetFitnessNewsRepository repository;

  GetFitnessNewsServiceImpl({required this.repository});
  @override
  Future<List<FitnessNewsModel>> getFitnessNews() async => await repository.getFitnessNews();
}
