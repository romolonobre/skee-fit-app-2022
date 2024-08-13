// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_container.dart';
import '../../../core/skee_ui/skee_palette.dart';
import '../../../core/widgets/flutter_widgets.dart';
import '../../domain/entities/exercises_entity.dart';

// ignore: must_be_immutable
class ExerciseCardWidget extends StatelessWidget {
  final ExerciseEntity exercise;
  final Function? ontap;
  final Color? color;
  final Widget trailing;
  bool? isSelected;

  ExerciseCardWidget({
    super.key,
    required this.exercise,
    required this.trailing,
    this.ontap,
    this.color,
    this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap != null ? () => ontap!() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SkeeContainer(
          color: color ?? SkeePalette.cardColor,
          child: Column(
            children: [
              ListTile(

                  // Image
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      exercise.gifUrl,
                      height: 55,
                      width: 55,
                    ),
                  ),

                  // Body target
                  title: SkeeText.custom(
                    exercise.target,
                    fontsize: 12,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),

                  // Exercise name
                  subtitle: SkeeText.title(
                    '${exercise.name} ',
                    fontsize: 14,
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                  ),
                  trailing: trailing),
            ],
          ),
        ),
      ),
    );
  }
}
