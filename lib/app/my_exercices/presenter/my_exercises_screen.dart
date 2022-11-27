import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../home/domain/models/exercises_model.dart';
import '../../home/presenter/cubit/get_all_exercises_cubit.dart';
import '../../home/screens/exercises_screen.dart';
import '../../widgets/we_buttons.dart';
import '../../widgets/we_modal.dart';
import '../../widgets/we_text.dart';
import 'widgets/workout_timer_widget.dart';

class MyExercicePage extends StatefulWidget {
  const MyExercicePage({Key? key}) : super(key: key);

  @override
  State<MyExercicePage> createState() => _MyExercicePageState();
}

class _MyExercicePageState extends State<MyExercicePage> {
  final cubit = Modular.get<GetAllExercisesCubit>();
  List<ExercisesModel> exercises = [];

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WEPalette.backgroudColor,
      appBar: AppBar(
        backgroundColor: const Color(0xff1e222e),
        elevation: 0,
        actions: [
          WeButtons.text(
            'Finish Workout',
            ontap: () => _finishWorkoutModal(),
          ),
        ],
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              child: CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        const WorkoutTimeWidget(),
                        SizedBox(height: exercises.isEmpty ? MediaQuery.of(context).size.height - 700 : 0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: exercises.isEmpty
                              ? WEText.title(
                                  'No exercises available \n Add a new exercise',
                                  textAlign: TextAlign.center,
                                  color: Colors.white,
                                  fontsize: 26,
                                )
                              : MyExercisesCard(exercises: exercises),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 35,
            left: 20,
            right: 20,
            child: WeButtons.filled(
              'Add Exercises',
              height: 55,
              ontap: () async {
                cubit.getAllExercises();

                final List<ExercisesModel>? result = await Modular.to.push(
                  MaterialPageRoute(
                    builder: (context) => ExercisesInfoPage(exercisesModel: exercises),
                  ),
                );

                setState(() {
                  exercises = result ?? [];
                });
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _finishWorkoutModal() async {
    WEModal(
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
            WEText.title('Finish Workout ?', fontsize: 15),
            const SizedBox(height: 14),
            WEText.custom(
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

  Future openExercisesdetailsModal(BuildContext context, ExercisesModel exercise) async {
    WEModal(
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
                    ClipRRect(
                      borderRadius: BorderRadius.circular(14),
                      child: Image.network(
                        exercise.gifUrl,
                        height: 55,
                        width: 55,
                      ),
                    ),
                    Container(
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
                    ),
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
