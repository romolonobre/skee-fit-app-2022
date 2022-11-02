import 'package:flutter/material.dart';

import '../../../skee_ui/skee_container.dart';
import '../../../skee_ui/skee_palette.dart';
import '../../../widgets/flutter_widgets.dart';
import '../../../widgets/we_buttons.dart';
import '../../domain/models/exercises_model.dart';

class ExerciseCardWidget extends StatelessWidget {
  final ExercisesModel exercise;
  final Function? ontap;

  const ExerciseCardWidget({
    Key? key,
    required this.exercise,
    this.ontap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => ontap != null ? ontap!() : null,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            child: SkeeContainer(
              color: exercise.isSelected ? WEPalette.primaryColor.withOpacity(0.5) : WEPalette.cardColor,
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
                    trailing: WeButtons.iconButton(
                      icon: Icons.info_outline,
                      backGroundColor: exercise.isSelected ? Colors.black26 : WEPalette.primaryColor.withOpacity(0.2),
                      iconColor: exercise.isSelected ? Colors.black : WEPalette.primaryColor.withOpacity(0.75),
                      ontap: () => openExercisesdetailsModal(context, exercise),
                    ),
                  ),
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

List<String> instructions = [
  '1. The first thing to do is warm up. It doesn’t matter what else follows. Your warm-up is essential to a safe and effective workout.',
  '2. Dynamic stretches are the building blocks of most warm-ups. These are high tempo,',
  '3. They engage muscles and practice the range of movements that you’re planning to use in your session. You’ve probably done plenty of these before.',
  '4. Arm circles. Chest claps. Alternating side bends. '
];
