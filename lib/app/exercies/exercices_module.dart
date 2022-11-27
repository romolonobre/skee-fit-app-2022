import 'package:flutter_modular/flutter_modular.dart';

import '../home/domain/repositories/get_all_exercices_repository.dart';
import '../home/domain/service/get_all_exercises_service.dart';
import '../home/presenter/cubit/get_all_exercises_cubit.dart';
import 'exercises_screen.dart';

class ExercisesModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<GetAllExercisesRepository>((i) => GetAllExercicesRepositoryImpl()),
        Bind.lazySingleton<GetAllExercisesService>((i) => GetAllExercisesServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetAllExercisesCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => ExercisesPage(exercisesModel: const [])),
      ];
}
