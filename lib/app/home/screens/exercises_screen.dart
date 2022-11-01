import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../skee_ui/we_loader.dart';
import '../../widgets/we_buttons.dart';
import '../domain/models/exercises_model.dart';
import '../presenter/cubit/get_all_exercises_cubit.dart';
import '../presenter/widgets/exercise_card_widget.dart';
import '../presenter/widgets/exercises_info_app_bar.dart';

class ExercisesInfoPage extends StatefulWidget {
  List<ExercisesModel> exercisesModel = [];

  ExercisesInfoPage({required this.exercisesModel});

  @override
  State<ExercisesInfoPage> createState() => _ExercisesInfoPageState();
}

class _ExercisesInfoPageState extends State<ExercisesInfoPage> {
  final cubit = Modular.get<GetAllExercisesCubit>();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ExercicesInfoAppBar(),
      body: BlocBuilder<GetAllExercisesCubit, GetAllExercisesState>(
        bloc: cubit,
        builder: (ctx, state) {
          if (state is GetAllExercisesLaodingState) {
            return const Center(
              child: WELoader(),
            );
          }

          if (state is GetAllExercisesErrorState) {
            return const Scaffold(
              body: Center(
                child: Text('error'),
              ),
            );
          }

          if (state is GetAllExerciseLoadedState) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 20,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height - 250,
                        child: ListView.builder(
                          itemCount: state.exercises.length,
                          itemBuilder: (cxt, index) {
                            final ExercisesModel execice = state.exercises[index];

                            return ExerciseCardWidget(
                              exercise: execice,
                              ontap: () {
                                setState(() {
                                  execice.isSelected = !execice.isSelected;
                                  if (execice.isSelected) {
                                    widget.exercisesModel.add(execice);
                                  }
                                  if (!execice.isSelected) {
                                    widget.exercisesModel.removeAt(index);
                                  }
                                });
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 40,
                  right: 40,
                  child: WeButtons.filled('Save', ontap: () async {
                    var selectedExercise = widget.exercisesModel;

                    Modular.to.pop(selectedExercise);
                  }),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
