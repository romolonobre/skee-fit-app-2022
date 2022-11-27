import 'package:flutter/material.dart';

import '../../../core/skee_ui/skee_container.dart';
import '../../../widgets/flutter_widgets.dart';
import '../../../widgets/we_buttons.dart';
import '../../domain/models/exercises_model.dart';

class CustomGridviewWidget extends StatefulWidget {
  final List<ExercisesModel> exercises;
  const CustomGridviewWidget({Key? key, required this.exercises}) : super(key: key);

  @override
  State<CustomGridviewWidget> createState() => _CustomGridviewWidgetState();
}

class _CustomGridviewWidgetState extends State<CustomGridviewWidget> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      ),
      itemCount: widget.exercises.length,
      itemBuilder: (context, index) {
        final exercise = widget.exercises[index];

        return GridTile(
          child: GestureDetector(
            onDoubleTap: () {},
            child: SkeeContainer(
              color: exercise.isDone ? Colors.green.withOpacity(0.2) : Colors.white,
              padding: const EdgeInsets.only(top: 5),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        WeButtons.iconButton(
                          icon: Icons.done,
                          width: 29,
                          height: 28,
                          backGroundColor: Colors.green.withOpacity(0.4),
                          iconColor: Colors.green,
                          ontap: () {
                            exercise.isDone = !exercise.isDone;
                            setState(() {});
                          },
                        ),
                        WeButtons.iconButton(
                          icon: Icons.remove,
                          width: 28,
                          height: 28,
                          backGroundColor: Colors.red.withOpacity(0.4),
                          iconColor: Colors.red,
                          ontap: () {
                            widget.exercises.removeAt(index);
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            exercise.gifUrl,
                            height: 80,
                            width: 80,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: WEText.title(
                            exercise.name,
                            textAlign: TextAlign.left,
                            fontsize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
