import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/exercises/datasource/exercise_datasource.dart';

import 'presenter/cubit/exercises_cubit.dart';
import 'presenter/exercises_screen.dart';
import 'repositories/exercices_repository_impl.dart';
import 'repositories/exercises_repository.dart';

class ExercisesModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<ExercisesDataSource>((i) => ExercisesDataSourceImpl()),
        Bind.lazySingleton<ExercisesRepository>((i) => ExercisesRepositoryImpl(dataSource: i())),
        Bind.lazySingleton((i) => ExercisesCubit(i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const ExercisesPage()),
      ];
}
