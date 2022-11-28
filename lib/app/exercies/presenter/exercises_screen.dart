import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/widgets/flutter_widgets.dart';

import '../../core/skee_ui/we_loader.dart';
import '../../home/presenter/widgets/exercise_card_widget.dart';
import '../../home/presenter/widgets/exercises_info_app_bar.dart';
import '../../widgets/we_buttons.dart';
import '../domain/models/exercises_model.dart';
import 'cubit/get_all_exercises_cubit.dart';

class ExercisesPage extends StatefulWidget {
  List<ExercisesModel> exercisesModel = [];

  ExercisesPage({required this.exercisesModel});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final cubit = Modular.get<GetAllExercisesCubit>();
  final text = TextEditingController();

  int currentIndex = 0;

  @override
  void initState() {
    cubit.getAllExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WEPalette.backgroudColor,
      appBar: ExercicesInfoAppBar(),
      body: BlocConsumer<GetAllExercisesCubit, GetAllExercisesState>(
        bloc: cubit,
        listener: (context, state) {
          if (state is GetAllExercisesErrorState) {
            ShowErrorMessage().call(state.errorMessage, context: context);
          }
        },
        builder: (ctx, state) {
          if (state is GetAllExercisesLaodingState) {
            return const Center(
              child: WELoader(),
            );
          }

          if (state is FilterLoaded) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
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
                ),
                Positioned(
                  bottom: 30,
                  left: 40,
                  right: 40,
                  child: WeButtons.filled(
                    'Save',
                    height: 55,
                    ontap: () async {
                      var selectedExercise = widget.exercisesModel;

                      Modular.to.pop(selectedExercise);
                    },
                  ),
                ),
              ],
            );
          }

          if (state is GetAllExerciseLoadedState) {
            return Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    left: 10,
                    right: 10,
                  ),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
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
                ),
                Positioned(
                  bottom: 30,
                  left: 40,
                  right: 40,
                  child: WeButtons.filled(
                    'Save',
                    height: 55,
                    ontap: () async {
                      var selectedExercise = widget.exercisesModel;

                      Modular.to.pop(selectedExercise);
                    },
                  ),
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
