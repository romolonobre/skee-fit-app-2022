import 'package:flutter_modular/flutter_modular.dart';

import 'domain/repositories/get_all_exercices_repository.dart';
import 'domain/repositories/get_fitness_news_repository.dart';
import 'domain/service/get_all_exercises_service.dart';
import 'domain/service/get_fitness_news_service.dart';
import 'presenter/cubit/get_all_exercises_cubit.dart';
import 'presenter/cubit/get_fitness_news_cubit.dart';
import 'screens/home_screen.dart';
import 'screens/my_exercises_screen.dart';

class HomeModule extends Module {
  @override
  // TODO: implement binds
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<GetAllExercisesRepository>((i) => GetAllExercicesRepositoryImpl()),
        Bind.lazySingleton<GetAllExercisesService>((i) => GetAllExercisesServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetAllExercisesCubit(i())),
        Bind.lazySingleton<GetFitnessNewsRepository>((i) => GetFitnessNewsRepositoryImpl()),
        Bind.lazySingleton<GetFitnessNewsService>((i) => GetFitnessNewsServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetFitnessNewsCubit(i()))
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
        ChildRoute('/add-exercise', child: (context, args) => const AddExercicePage()),
      ];
}
