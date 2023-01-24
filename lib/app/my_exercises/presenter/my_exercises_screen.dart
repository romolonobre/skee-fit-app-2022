// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/my_exercises/presenter/widgets/bottomsheets/bottomsheet.dart';
import 'package:skeefiapp/app/my_exercises/presenter/widgets/no_exercise_widget.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../exercises/domain/models/exercises_model.dart';
import '../../exercises/presenter/cubit/all_exercises_cubit.dart';
import '../../exercises/presenter/exercises_screen.dart';
import '../../widgets/skee_button.dart';
import 'widgets/add_exercises_button.dart';
import 'widgets/my_exercise_card.dart';
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
      backgroundColor: SkeePalette.backgroudColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0,
              pinned: true,
              snap: true,
              floating: true,
              bottom: const PreferredSize(
                preferredSize: Size(0, 120),
                child: WorkoutTimeWidget(),
              ),
              backgroundColor: SkeePalette.backgroudColor,
              actions: [
                SkeeButton.text(
                  'Finish Workout',
                  ontap: () => OpenBottomsheet.finishWorkout(context),
                ),
              ],
            )
          ];
        },
        body: Stack(
          alignment: Alignment.center,
          children: [
            exercises.isEmpty ? const NoExerciseWidget() : MyExercisesBody(exercises: exercises),
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
      ),
    );
  }
}
