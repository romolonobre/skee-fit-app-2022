import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/home/presenter/cubit/imagepicker_cubit.dart';
import 'package:skeefiapp/app/home/service/image_picker_service.dart';
import 'package:skeefiapp/app/my_exercises/my_exercies_module.dart';

import 'presenter/cubit/get_fitness_news_cubit.dart';
import 'presenter/home_screen.dart';
import 'repositories/get_fitness_news_repository.dart';
import 'service/get_fitness_news_service.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
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
