// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_container.dart';
import '../../../core/skee_ui/skee_palette.dart';
import '../../../widgets/flutter_widgets.dart';
import '../../domain/entities/exercises_entity.dart';

class ExerciseCardWidget extends StatelessWidget {
  final ExerciseEntity exercise;
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
      onTap: ontap != null ? () => ontap!() : null,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SkeeContainer(
          color: color ?? SkeePalette.cardColor,
          child: Column(
            children: [
              ListTile(
                  leading: _ExerciseGifCard(exercise: exercise),
                  title: _ExerciseName(exercise: exercise),
                  subtitle: _ExerciseDescrition(exercise: exercise),
                  trailing: trailing),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExerciseName extends StatelessWidget {
  const _ExerciseName({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return SkeeText.custom(
      exercise.target,
      fontsize: 12,
      color: Colors.white,
      fontWeight: FontWeight.w400,
    );
  }
}

class _ExerciseDescrition extends StatelessWidget {
  const _ExerciseDescrition({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final ExerciseEntity exercise;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: SkeeText.title(
        '${exercise.name} ',
        fontsize: 14,
        color: Colors.white,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class _ExerciseGifCard extends StatelessWidget {
  const _ExerciseGifCard({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final ExerciseEntity exercise;

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
