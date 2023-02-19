// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/my_exercises/presenter/widgets/bottomsheets/bottomsheet.dart';
import 'package:skeefiapp/app/my_exercises/presenter/widgets/workout_timer_widget.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../exercises/domain/entities/exercises_entity.dart';
import '../../exercises/presenter/cubit/all_exercises_cubit.dart';
import '../../widgets/skee_button.dart';

class MyExercisesPage extends StatefulWidget {
  const MyExercisesPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MyExercisesPage> createState() => _MyExercisesPageState();
}

class _MyExercisesPageState extends State<MyExercisesPage> {
  final cubit = Modular.get<GetAllExercisesCubit>();
  List<ExerciseEntity> exercises = [];

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
              bottom: const PreferredSize(
                preferredSize: Size(0, 120),
                child: WorkoutTimerWidget(),
              ),
              backgroundColor: SkeePalette.backgroudColor,
              actions: [
                SkeeButton.text(
                  'Fdededeeded',
                  ontap: () => OpenBottomsheet.finishWorkout(context),
                ),
              ],
            )
          ];
        },
        body: Stack(
          alignment: Alignment.center,
          children: const [],
        ),
      ),
    );
  }
}

// tests coments
