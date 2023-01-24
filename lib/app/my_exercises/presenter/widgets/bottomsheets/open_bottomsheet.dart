import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../exercises/domain/models/exercises_model.dart';
import '../../../../widgets/skee_modal.dart';
import '../../../../widgets/skee_text.dart';

class OpenBottomsheet {
  static Future<void> finishWorkout(BuildContext context) async {
    SkeeModal(
      context,
      onCancel: () {},
      onConfirm: () => Modular.to.pushNamed('/home'),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        height: 180,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SkeeText.title('Finish Workout ?', fontsize: 15),
            const SizedBox(height: 14),
            SkeeText.custom(
              "All the exercises will be removed. \n if you did not finish the workout \nthe exercises will be mark as \ncompleted",
              fontsize: 15,
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> exerciseDetail(BuildContext context, ExercisesModel exercise) async {
    SkeeModal(
      context,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        // height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width - 80,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                exercise.gifUrl,
                height: 230,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
