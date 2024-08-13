import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/core/widgets/custom_error_widget.dart';
import 'package:skeefiapp/app/exercises/presenter/widgets/exercise_card_widget.dart';

import '../../core/skee_ui/skee_loader.dart';
import '../../core/widgets/skee_button.dart';
import '../domain/entities/exercises_entity.dart';
import 'cubit/exercises_cubit.dart';

class ExercisesPage extends StatefulWidget {
  const ExercisesPage({super.key});

  @override
  State<ExercisesPage> createState() => _ExercisesPageState();
}

class _ExercisesPageState extends State<ExercisesPage> {
  final cubit = Modular.get<ExercisesCubit>();
  List<ExerciseEntity> exercisesModel = [];

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
      body: BlocBuilder<ExercisesCubit, ExercisesState>(
        bloc: cubit,
        builder: (ctx, state) {
          if (state is ExercisesLoadingState) {
            return const Center(
              child: SkeeLoader(),
            );
          }

          if (state is ExercisesErrorState) {
            return CustomErrorWidget(
              errorMessage: state.errorMessage,
              ontap: () => cubit.getAllExercises(),
            );
          }

          if (state is ExercisesLoadedState) {
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
                        ontap: () => {},
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
                            ontap: () => {}),
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
                    ontap: () => Modular.to.pop(exercisesModel),
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
