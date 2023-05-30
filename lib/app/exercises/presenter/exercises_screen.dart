import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/exercises/presenter/widgets/exercise_card_widget.dart';
import 'package:skeefiapp/app/widgets/custom_error_widget.dart';

import '../../core/skee_ui/skee_loader.dart';
import '../../widgets/skee_button.dart';
import '../domain/entities/exercises_entity.dart';
import 'cubit/all_exercises_cubit.dart';
import 'widgets/details_bottomsheet.dart';
import 'widgets/exercises_info_app_bar.dart';

class ExercisesPage extends StatefulWidget {
  List<ExerciseEntity> exercisesModel = [];

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
            return CustomErrorWidget(
              errorMessage: state.errorMessage,
              ontap: () => cubit.getAllExercises(),
            );
          }

          if (state is FilterLoaded) {
            return Stack(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: state.exercises.length,
                    itemBuilder: (cxt, index) {
                      final ExerciseEntity exercise = state.exercises[index];

                      return ExerciseCardWidget(
                        exercise: exercise,
                        ontap: () => setState(() => onExerciseSelected(exercise, index)),
                        color: exercise.isSelected ? SkeePalette.primaryColor.withOpacity(0.5) : SkeePalette.cardColor,
                        trailing: SkeeButton.iconButton(
                          icon: Icons.info_outline,
                          backGroundColor:
                              exercise.isSelected ? Colors.black26 : SkeePalette.primaryColor.withOpacity(0.2),
                          iconColor: exercise.isSelected ? Colors.black : SkeePalette.primaryColor.withOpacity(0.75),
                          ontap: () => DetailsBottomsheet.openExercisesdetail(context, exercise),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 40,
                  right: 40,
                  child: SkeeButton.filled(
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
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    itemCount: state.exercises.length,
                    itemBuilder: (cxt, index) {
                      final ExerciseEntity exercise = state.exercises[index];

                      return ExerciseCardWidget(
                        exercise: exercise,
                        ontap: () => setState(() => onExerciseSelected(exercise, index)),
                        color: exercise.isSelected
                            ? SkeePalette.primaryColor.withOpacity(0.5) //
                            : SkeePalette.cardColor,
                        trailing: SkeeButton.iconButton(
                          icon: Icons.info_outline,
                          backGroundColor: exercise.isSelected
                              ? Colors.black26 //
                              : SkeePalette.primaryColor.withOpacity(0.2),
                          iconColor: exercise.isSelected
                              ? Colors.black //
                              : SkeePalette.primaryColor.withOpacity(0.75),
                          ontap: () => DetailsBottomsheet.openExercisesdetail(context, exercise),
                        ),
                      );
                    },
                  ),
                ),
                Positioned(
                  bottom: 30,
                  left: 40,
                  right: 40,
                  child: SkeeButton.filled(
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

  void onExerciseSelected(ExerciseEntity exercise, int index) {
    exercise.isSelected = !exercise.isSelected;
    if (exercise.isSelected) {
      widget.exercisesModel.add(exercise);
    }
    if (!exercise.isSelected) {
      widget.exercisesModel.removeAt(index);
    }
  }
}
