import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/splashscreen/splash_screen.dart';

import 'home/home_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/splashscreen', child: (context, args) => const SplashScreen(), transition: TransitionType.fadeIn),
        ChildRoute('/', child: (context, args) => const SplashScreen(), transition: TransitionType.fadeIn),
        ModuleRoute('/home', module: HomeModule(), transition: TransitionType.fadeIn),
      ];
}
