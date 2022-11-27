import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/home/domain/service/image_picker_service.dart';
import 'package:skeefiapp/app/home/presenter/cubit/imagepicker_cubit.dart';
import 'package:skeefiapp/app/my_exercices/my_exercies_module.dart';

import 'domain/repositories/get_all_exercices_repository.dart';
import 'domain/repositories/get_fitness_news_repository.dart';
import 'domain/service/get_all_exercises_service.dart';
import 'domain/service/get_fitness_news_service.dart';
import 'presenter/cubit/get_all_exercises_cubit.dart';
import 'presenter/cubit/get_fitness_news_cubit.dart';
import 'screens/home_screen.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton<GetAllExercisesRepository>((i) => GetAllExercicesRepositoryImpl()),
        Bind.lazySingleton<GetAllExercisesService>((i) => GetAllExercisesServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetAllExercisesCubit(i())),
        Bind.lazySingleton<GetFitnessNewsRepository>((i) => GetFitnessNewsRepositoryImpl()),
        Bind.lazySingleton<GetFitnessNewsService>((i) => GetFitnessNewsServiceImpl(repository: i())),
        Bind.lazySingleton((i) => GetFitnessNewsCubit(i())),
        Bind.lazySingleton((i) => ImagepickerCubit()),
        Bind.lazySingleton<ImagePickerService>((i) => ImagePickerServiceImpl()),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
        ModuleRoute('/my-exercise', module: MyExerciesModule()),
      ];
}
