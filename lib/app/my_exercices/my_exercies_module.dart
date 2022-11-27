import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/my_exercises_screen.dart';

class MyExerciesModule extends Module {
  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const MyExercicePage(),
        )
      ];
}
