// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../widgets/skee_button.dart';

// ignore: must_be_immutable
class AddExercisebutton extends StatelessWidget {
  final Function ontap;
  const AddExercisebutton({super.key, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 20,
      right: 20,
      child: WeButtons.filled(
        'Add Exercises',
        height: 55,
        ontap: () => ontap(),
      ),
    );
  }
}
