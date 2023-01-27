// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../exercises/domain/models/exercises_model.dart';
import '../../../exercises/presenter/widgets/exercise_card_widget.dart';
import '../../../widgets/skee_button.dart';
import 'custom_dimissible_widget.dart';

class MyExercisesBody extends StatefulWidget {
  final List<ExercisesModel> exercises;

  const MyExercisesBody({super.key, required this.exercises});

  @override
  State<MyExercisesBody> createState() => _MyExercisesBodyState();
}

class _MyExercisesBodyState extends State<MyExercisesBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];

          return CustomDimissibleWidget(
            child: ExerciseCardWidget(
              exercise: exercise,
              trailing: SkeeButton.iconButton(
                height: 30,
                width: 30,
                icon: Icons.done,
                backGroundColor: exercise.isDone ? Colors.pink : Colors.black26,
                iconColor: Colors.black,
                ontap: () {},
              ),
              ontap: () async => {
                await HapticFeedback.lightImpact(),
                setState(() => exercise.isDone = !exercise.isDone),
              },
            ),
            onDismissed: (direction) => setState(() => widget.exercises.removeAt(index)),
          );
        },
      ),
    );
  }
}
