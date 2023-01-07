// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/my_exercises/presenter/widgets/my_exercise_card.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../exercies/domain/models/exercises_model.dart';
import '../../exercies/presenter/cubit/get_all_exercises_cubit.dart';
import '../../exercies/presenter/exercises_screen.dart';
import '../../widgets/we_buttons.dart';
import '../../widgets/we_modal.dart';
import '../../widgets/we_text.dart';
import 'widgets/add_exercises_button.dart';
import 'widgets/workout_timer_widget.dart';

class MyExercisesPage extends StatefulWidget {
  const MyExercisesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyExercisesPage> createState() => _MyExercisesPageState();
}

class _MyExercisesPageState extends State<MyExercisesPage> {
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
                        SizedBox(height: exercises.isEmpty ? MediaQuery.of(context).size.height - 600 : 0),
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          child: exercises.isEmpty ? noExerciceAvaliableText() : MyExercisesCard(exercises: exercises),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          AddExercisebutton(
            ontap: () async {
              final List<ExercisesModel>? result = await Modular.to.push(
                MaterialPageRoute(builder: (context) => ExercisesPage(exercisesModel: exercises)),
              );
              setState(() => exercises = result ?? []);
            },
          )
        ],
      ),
    );
  }

  Widget noExerciceAvaliableText() {
    return WEText.title(
      'No exercises available. \n Add a new exercise',
      textAlign: TextAlign.center,
      color: Colors.white,
      fontsize: 26,
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
