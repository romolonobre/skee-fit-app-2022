import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../exercies/domain/models/exercises_model.dart';
import '../../../widgets/we_buttons.dart';
import '../../../widgets/we_text.dart';

class MyExercisesCard extends StatefulWidget {
  final List<ExercisesModel> exercises;
  const MyExercisesCard({super.key, required this.exercises});

  @override
  State<MyExercisesCard> createState() => _MyExercisesCardState();
}

class _MyExercisesCardState extends State<MyExercisesCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 270),
      child: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];

          return GestureDetector(
            onTap: () {
              exercise.isDone = !exercise.isDone;
              setState(() {});
            },
            child: Dismissible(
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              background: Container(
                width: 20,
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 15,
                ),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: Colors.red.shade400,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: const [
                    Icon(
                      Icons.delete_outline_outlined,
                      size: 50,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              onDismissed: (direction) {
                widget.exercises.removeAt(index);
                setState(() {});
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                margin: const EdgeInsets.only(top: 8),
                decoration: BoxDecoration(
                  color: WEPalette.cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ExerciseGifCard(exercise: exercise),
                    ExerciseNameAndTarget(exercise: exercise),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15),
                      child: WeButtons.iconButton(
                        height: 30,
                        width: 30,
                        icon: Icons.done,
                        backGroundColor: exercise.isDone ? Colors.pink : Colors.black26,
                        iconColor: Colors.black,
                        ontap: () {
                          exercise.isDone = !exercise.isDone;
                          setState(() {});
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ExerciseNameAndTarget extends StatelessWidget {
  const ExerciseNameAndTarget({
    Key? key,
    required this.exercise,
  }) : super(key: key);

  final ExercisesModel exercise;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 8, top: 10),
      width: MediaQuery.of(context).size.width - 190,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WEText.title(
            exercise.name,
            fontsize: 13,
            fontWeight: FontWeight.w500,
            color: Colors.white,
            textAlign: TextAlign.left,
          ),
          const SizedBox(height: 7),
          WEText.title(
            exercise.target,
            fontsize: 13,
            fontWeight: FontWeight.w200,
            color: Colors.white,
            textAlign: TextAlign.left,
          ),
        ],
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
