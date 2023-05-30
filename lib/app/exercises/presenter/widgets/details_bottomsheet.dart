import 'package:flutter/material.dart';

import '../../../widgets/skee_modal.dart';
import '../../domain/entities/exercises_entity.dart';

class DetailsBottomsheet {
  static Future openExercisesdetail(BuildContext context, ExerciseEntity exercise) async {
    SkeeModal(
      context,
      height: 300,
      cancelText: 'Done',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                exercise.gifUrl,
                height: 190,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
