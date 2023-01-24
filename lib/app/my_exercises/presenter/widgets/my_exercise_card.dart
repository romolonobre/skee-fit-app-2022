import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../exercises/domain/models/exercises_model.dart';
import '../../../exercises/presenter/widgets/exercise_card_widget.dart';
import '../../../widgets/skee_button.dart';
import '../../../widgets/skee_modal.dart';
import '../../../widgets/skee_text.dart';

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

          return Dismissible(
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
            onDismissed: (direction) => setState(() => widget.exercises.removeAt(index)),
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
              ontap: () => setState(() => exercise.isDone = !exercise.isDone),
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
    SkeeModal(
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
            SkeeText.title('Well done!', fontsize: 15),
            const SizedBox(height: 14),
            SkeeText.custom(
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
