import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/widgets/custom_error_widget.dart';

import '../../core/skee_ui/we_loader.dart';
import '../../home/presenter/widgets/exercise_card_widget.dart';
import '../../home/presenter/widgets/exercises_info_app_bar.dart';
import '../../widgets/snackbar/show_error_message.dart';
import '../../widgets/we_buttons.dart';
import '../../widgets/we_modal.dart';
import '../domain/models/exercises_model.dart';
import 'cubit/get_all_exercises_cubit.dart';

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
        listener: (context, state) {},
        builder: (ctx, state) {
          if (state is GetAllExercisesLaodingState) {
            return const Center(
              child: SKEELoader(),
            );
          }

          if (state is GetAllExercisesErrorState) {
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
                          trailing: WeButtons.iconButton(
                            icon: Icons.info_outline,
                            backGroundColor:
                                exercise.isSelected ? Colors.black26 : WEPalette.primaryColor.withOpacity(0.2),
                            iconColor: exercise.isSelected ? Colors.black : WEPalette.primaryColor.withOpacity(0.75),
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
                        final ExercisesModel exercise = state.exercises[index];

                        return ExerciseCardWidget(
                          exercise: exercise,
                          ontap: () => setState(() => selecetAndUnSelectExercise(exercise, index)),
                          color: exercise.isSelected ? WEPalette.primaryColor.withOpacity(0.5) : WEPalette.cardColor,
                          trailing: WeButtons.iconButton(
                            icon: Icons.info_outline,
                            backGroundColor:
                                exercise.isSelected ? Colors.black26 : WEPalette.primaryColor.withOpacity(0.2),
                            iconColor: exercise.isSelected ? Colors.black : WEPalette.primaryColor.withOpacity(0.75),
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
