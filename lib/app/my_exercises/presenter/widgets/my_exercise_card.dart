import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/widgets/flutter_widgets.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../exercies/domain/models/exercises_model.dart';
import '../../../widgets/we_buttons.dart';

class MyExercisesCard extends StatefulWidget {
  final List<ExercisesModel> exercises;

  const MyExercisesCard({super.key, required this.exercises});

  @override
  State<MyExercisesCard> createState() => _MyExercisesCardState();
}

class _MyExercisesCardState extends State<MyExercisesCard> {
  @override
  Widget build(BuildContext context) {
    // print(currentIndex);
    return Padding(
      padding: const EdgeInsets.only(bottom: 270),
      child: ListView.builder(
        itemCount: widget.exercises.length,
        itemBuilder: (context, index) {
          final exercise = widget.exercises[index];

          return GestureDetector(
            onTap: () {
              setState(() => exercise.isDone = !exercise.isDone);
              _isWorkoutCompleted()
                  ? _openWorkOutCompletedModal(ontap: () => setState(() => exercise.isDone = !exercise.isDone))
                  : null;
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

  bool _isWorkoutCompleted() {
    return widget.exercises.every((element) => element.isDone == true);
  }

  Future<void> _openWorkOutCompletedModal({required Function ontap}) async {
    WEModal(
      context,
      onCancel: () => ontap(),
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
            WEText.title('Well done!', fontsize: 15),
            const SizedBox(height: 14),
            WEText.custom(
              "You have completed your workout.",
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
