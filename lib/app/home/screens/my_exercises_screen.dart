import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../widgets/we_buttons.dart';
import '../../widgets/we_modal.dart';
import '../../widgets/we_text.dart';
import '../domain/models/exercises_model.dart';
import '../presenter/cubit/get_all_exercises_cubit.dart';
import '../presenter/widgets/custom_gridview_widget.dart';
import '../presenter/widgets/workout_timer_widget.dart';
import 'exercises_screen.dart';

class AddExercicePage extends StatefulWidget {
  const AddExercicePage({Key? key}) : super(key: key);

  @override
  State<AddExercicePage> createState() => _AddExercicePageState();
}

class _AddExercicePageState extends State<AddExercicePage> {
  final cubit = Modular.get<GetAllExercisesCubit>();
  List<ExercisesModel> exercises = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          WeButtons.text('Finish Workout', ontap: () => _finishWorkoutModal()),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WorkoutTimeWidget(),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height - 350,
                width: MediaQuery.of(context).size.width,
                child: exercises.isEmpty
                    ? Center(
                        child: WEText.title(
                          'No exercises available \n add a new exercise',
                          textAlign: TextAlign.center,
                          color: Colors.grey[400],
                        ),
                      )
                    : CustomGridviewWidget(exercises: exercises),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: WeButtons.filled(
                  'Add Exercises',
                  height: 34,
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
              ),
            ],
          ),
        ),
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
