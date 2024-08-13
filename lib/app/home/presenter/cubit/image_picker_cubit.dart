import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:skeefiapp/app/home/service/image_picker_service.dart';

import 'image_picker_state.dart';

class ImagePickerCubit extends Cubit<ImagePickerState> {
  ImagePickerCubit() : super(ImagePickerLoaded());

  final imageService = Modular.get<ImagePickerService>();

  Future<XFile?> pickImage(ImageSource source) async {
    try {
      XFile? image = await imageService.pick(source);
      if (image == null) return null;
      final imagePermanet = await saveImage(image.path);

      emit(ImagePickerLoaded(image: imagePermanet));
    } on PlatformException catch (e) {
      emit(ImagePickerError(message: e.message ?? "Unable to load image"));
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
