import 'package:flutter_modular/flutter_modular.dart';

import 'datasource/youtube_datasource.dart';
import 'presenter/cubit/image_picker_cubit.dart';
import 'presenter/cubit/youtube_videos_cubit.dart';
import 'presenter/home_screen.dart';
import 'repositories/youtube_repository.dart';
import 'service/image_picker_service.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => ImagePickerCubit()),
        Bind.lazySingleton<ImagePickerService>((i) => ImagePickerServiceImpl()),
        Bind.lazySingleton<YoutubeDataSource>((i) => YoutubeDataSourceImpl()),
        Bind.lazySingleton<YoutubeRepository>((i) => YoutubeRepositoryImpl(datasource: i())),
        Bind.lazySingleton<YoutubeVideosCubit>((i) => YoutubeVideosCubit(repository: i())),
      ];
  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomeScreen()),
      ];
}
