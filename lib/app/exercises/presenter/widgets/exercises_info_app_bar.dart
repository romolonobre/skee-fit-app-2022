import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../widgets/flutter_widgets.dart';
import '../cubit/all_exercises_cubit.dart';

class ExercicesInfoAppBar extends StatefulWidget with PreferredSizeWidget {
  ExercicesInfoAppBar({
    Key? key,
  }) : super(key: key);

  @override
  State<ExercicesInfoAppBar> createState() => _ExercicesInfoAppBarState();
  @override
  Size get preferredSize => const Size.fromHeight(70);
}

class _ExercicesInfoAppBarState extends State<ExercicesInfoAppBar> {
  final input = TextEditingController();
  final cubit = Modular.get<GetAllExercisesCubit>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      backgroundColor: SkeePalette.backgroudColor,
      elevation: 0,
      leadingWidth: 40,
      leading: IconButton(
        onPressed: () => Modular.to.pop(),
        icon: const Icon(Icons.arrow_back_ios),
        splashRadius: 1,
      ),
      title: Column(
        children: [
          // Search Bar
          //
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 24),
            child: Padding(
              padding: const EdgeInsets.only(right: 30),
              child: SkeeCustomTextfield(
                  controller: input,
                  hintText: "Search by body target",
                  icon: Icons.search,
                  onChanged: (value) async =>
                      value.length >= 3 ? await cubit.filterExercises(value.toLowerCase()) : null,
                  ontap: () => cubit.filterExercises(input.text)),
            ),
          ),
        ],
      ),
    );
  }
}
