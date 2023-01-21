import 'package:flutter_modular/flutter_modular.dart';

import '../exercises/exercices_module.dart';
import '../exercises/presenter/cubit/all_exercises_cubit.dart';
import '../exercises/repositories/get_all_exercices_repository_impl.dart';
import '../exercises/repositories/get_all_exercises_repository.dart';
import '../exercises/services/get_all_exercises_service.dart';
import 'presenter/my_exercises_screen.dart';

class MyExerciesModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<GetAllExercisesRepository>((i) => GetAllExercisesRepositoryImpl()),
        Bind.lazySingleton<GetAllExercisesService>((i) => GetAllExercisesServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetAllExercisesCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const MyExercisesPage()),
        ModuleRoute('/exercises', module: ExercisesModule())
      ];
}
