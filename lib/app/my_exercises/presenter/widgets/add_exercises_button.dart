// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../exercies/domain/models/exercises_model.dart';
import '../../../widgets/we_buttons.dart';

// ignore: must_be_immutable
class AddExerciseButton extends StatefulWidget {
  List<ExercisesModel> exercises;
  Function ontap;

  AddExerciseButton({
    Key? key,
    required this.exercises,
    required this.ontap,
  }) : super(key: key);
  @override
  State<AddExerciseButton> createState() => _AddExerciseButtonState();
}

class _AddExerciseButtonState extends State<AddExerciseButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 35,
      left: 20,
      right: 20,
      child: WeButtons.filled(
        'Add Exercises',
        height: 55,
        ontap: widget.ontap(),
      ),
    );
  }
}
