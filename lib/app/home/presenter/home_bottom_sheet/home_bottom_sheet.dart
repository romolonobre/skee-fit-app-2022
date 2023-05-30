import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../widgets/skee_bottom_sheet.dart';
import '../../../widgets/skee_button.dart';
import '../../../widgets/skee_text.dart';

class HomeBottomSheet {
  static Future openStartWorkout(BuildContext context) async {
    SkeeBottomSheet.show(
      context,
      floatted: true,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SkeeText.title(
            'Workout Started!',
            fontsize: 20,
            color: SkeePalette.primaryColor,
            fontWeight: FontWeight.w700,
          ),
          const SizedBox(height: 15),
          SkeeText.custom(
            'Workout consist of a collection \n of exercises',
            fontsize: 16,
            textAlign: TextAlign.center,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          SkeeText.custom(
            "This workout is empty right now, but it's \n super easy to add some exercises to \n perform ",
            fontsize: 16,
            textAlign: TextAlign.center,
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 20),
          SkeeButton.filled(height: 50, "Let's build my workout", ontap: () {
            Modular.to.pushNamed('./my-exercise/');
            Modular.to.pop();
          }),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
