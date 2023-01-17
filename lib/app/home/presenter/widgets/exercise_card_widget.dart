// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_container.dart';
import '../../../core/skee_ui/skee_palette.dart';
import '../../../exercises/domain/models/exercises_model.dart';
import '../../../widgets/flutter_widgets.dart';

class ExerciseCardWidget extends StatelessWidget {
  final ExercisesModel exercise;
  final Function? ontap;
  final Color? color;
  final Widget trailing;
  bool? isSelected;

  ExerciseCardWidget({
    Key? key,
    required this.exercise,
    required this.trailing,
    this.ontap,
    this.color,
    this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap != null ? ontap!() : null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: SkeeContainer(
              color: color ?? WEPalette.cardColor,
              child: Column(
                children: [
                  ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(exercise.gifUrl),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: WEText.title(
                          '${exercise.name} ',
                          fontsize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      subtitle: WEText.custom(
                        exercise.target,
                        fontsize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                      trailing: trailing),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future openExercisesdetailsModal(BuildContext context, ExercisesModel exercise) async {
    WEModal(
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

class ExerciseGifCard extends StatelessWidget {
  const ExerciseGifCard({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final ExercisesModel exercise;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: Image.network(
        exercise.gifUrl,
        height: 55,
        width: 55,
      ),
    );
  }
}
