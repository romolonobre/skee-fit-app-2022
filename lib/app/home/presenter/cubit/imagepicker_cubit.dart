import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeefiapp/app/home/service/image_picker_service.dart';

part 'imagepicker_state.dart';

class ImagepickerCubit extends Cubit<ImagepickerState> {
  ImagepickerCubit() : super(ImagepickerLoaded());

  final imageService = Modular.get<ImagePickerService>();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      XFile? image = await imageService.pick(source);
      if (image == null) return null;
      final imagePermanet = await saveImage(image.path);

      emit(ImagepickerLoaded(image: imagePermanet));
    } on PlatformException catch (e) {
      emit(ImagepickerError(message: e.message ?? "Unable to load image"));
    }
    return null;
  }

  Future<File?> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }
}
