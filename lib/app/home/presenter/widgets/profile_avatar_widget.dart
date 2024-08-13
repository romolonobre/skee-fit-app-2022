import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:image_picker/image_picker.dart';
import 'package:skeefiapp/app/core/widgets/flutter_widgets.dart';
import 'package:skeefiapp/app/core/widgets/skee_button.dart';
import 'package:skeefiapp/app/core/widgets/snackbar/skee_snackbar_widget.dart';
import 'package:skeefiapp/app/home/presenter/cubit/ImagePicker_cubit.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../cubit/image_picker_state.dart';

class ProfileAvatarWidget extends StatelessWidget {
  ProfileAvatarWidget({Key? key}) : super(key: key);

  final cubit = Modular.get<ImagePickerCubit>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        _openImagePicker(context);
        await HapticFeedback.lightImpact();
      },
      child: BlocConsumer<ImagePickerCubit, ImagePickerState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is ImagePickerError) {
            showSnackbar(context, state.message, SnackBarStatus.error);
          }
        },
        builder: (context, state) {
          if (state is ImagePickerError) {
            return const CircleAvatar(
              radius: 60,
              backgroundColor: SkeePalette.primaryColor,
              child: Icon(Icons.camera_alt_rounded),
            );
          }

          if (state is ImagePickerLoaded) {
            return CircleAvatar(
              radius: 60,
              backgroundColor: SkeePalette.primaryColor,
              backgroundImage: state.image != null ? AssetImage(state.image!.path) : null,
              child: state.image == null ? const Icon(Icons.camera_alt_rounded) : null,
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  _openImagePicker(BuildContext context) async {
    SkeeBottomSheet.show(
      context,
      floatted: true,
      content: SizedBox(
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeeButton.filled(
              'Gallery',
              ontap: () async {
                Modular.to.pop();
                await cubit.pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: 10),
            SkeeButton.filled(
              'Camera',
              ontap: () async {
                Modular.to.pop();
                await cubit.pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
