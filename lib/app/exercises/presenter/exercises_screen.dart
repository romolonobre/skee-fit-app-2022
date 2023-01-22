import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/exercises/presenter/widgets/exercise_card_widget.dart';
import 'package:skeefiapp/app/widgets/custom_error_widget.dart';

import '../../core/skee_ui/skee_loader.dart';
import '../../widgets/snackbar/show_error_message.dart';
import '../../widgets/we_buttons.dart';
import '../../widgets/we_modal.dart';
import '../domain/models/exercises_model.dart';
import 'cubit/all_exercises_cubit.dart';
import 'widgets/exercises_info_app_bar.dart';

class ExercisesPage extends StatefulWidget {
  List<ExercisesModel> exercisesModel = [];

  ExercisesPage({
    super.key,
    required this.exercisesModel,
  });

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final cubit = Modular.get<GetAllExercisesCubit>();

  int currentIndex = 0;

  @override
  void initState() {
    cubit.getAllExercises();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SkeePalette.backgroudColor,
      appBar: ExercicesInfoAppBar(),
      body: BlocConsumer<GetAllExercisesCubit, GetAllExercisesState>(
        bloc: cubit,
        listener: (context, state) {},
        builder: (ctx, state) {
          if (state is GetAllExercisesLaodingState) {
            return const Center(
              child: SkeeLoader(),
            );
          }

          if (state is AllExercisesErrorState) {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              ShowErrorMessage().call(state.errorMessage.toString(), context: context);
            });

            return CustomErrorWidget(
                errorMessage: "Error when tried to load exercises", ontap: () => cubit.getAllExercises());
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
                        final ExercisesModel exercise = state.exercises[index];

                        return ExerciseCardWidget(
                          exercise: exercise,
                          ontap: () => setState(() => selecetAndUnSelectExercise(exercise, index)),
                          color:
                              exercise.isSelected ? SkeePalette.primaryColor.withOpacity(0.5) : SkeePalette.cardColor,
                          trailing: WeButtons.iconButton(
                            icon: Icons.info_outline,
                            backGroundColor:
                                exercise.isSelected ? Colors.black26 : SkeePalette.primaryColor.withOpacity(0.2),
                            iconColor: exercise.isSelected ? Colors.black : SkeePalette.primaryColor.withOpacity(0.75),
                            ontap: () => openExercisesdetailsModal(context, exercise),
                          ),
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

          if (state is AllExerciseLoadedState) {
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
                        final ExercisesModel exercise = state.exercises[index];

                        return ExerciseCardWidget(
                          exercise: exercise,
                          ontap: () => setState(() => selecetAndUnSelectExercise(exercise, index)),
                          color:
                              exercise.isSelected ? SkeePalette.primaryColor.withOpacity(0.5) : SkeePalette.cardColor,
                          trailing: WeButtons.iconButton(
                            icon: Icons.info_outline,
                            backGroundColor:
                                exercise.isSelected ? Colors.black26 : SkeePalette.primaryColor.withOpacity(0.2),
                            iconColor: exercise.isSelected ? Colors.black : SkeePalette.primaryColor.withOpacity(0.75),
                            ontap: () => openExercisesdetailsModal(context, exercise),
                          ),
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

  Future openExercisesdetailsModal(BuildContext context, ExercisesModel exercise) async {
    WEModal(
      context,
      height: 300,
      cancelText: 'Done',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.network(
                exercise.gifUrl,
                height: 190,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void selecetAndUnSelectExercise(ExercisesModel exercise, int index) {
    exercise.isSelected = !exercise.isSelected;
    if (exercise.isSelected) {
      widget.exercisesModel.add(exercise);
    }
    if (!exercise.isSelected) {
      widget.exercisesModel.removeAt(index);
    }
  }
}
