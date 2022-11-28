import 'package:image_picker/image_picker.dart';

abstract class ImagePickerService {
  Future<XFile?> pick(ImageSource souce);
}

class ImagePickerServiceImpl implements ImagePickerService {
  final _imagePicker = ImagePicker();

  @override
  Future<XFile?> pick(ImageSource souce) async {
    final image = await _imagePicker.pickImage(source: souce);
    if (image == null) return null;
    return image;
  }
}
