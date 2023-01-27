import 'package:flutter/material.dart';

import '../../../widgets/skee_text.dart';

class NoExerciseWidget extends StatelessWidget {
  const NoExerciseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 120,
      ),
      child: SkeeText.title(
        'No exercises available. \n Add a new exercise',
        textAlign: TextAlign.center,
        fontWeight: FontWeight.w300,
        color: Colors.white,
        fontsize: 24,
      ),
    );
  }
}
