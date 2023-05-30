import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:skeefiapp/app/widgets/flutter_widgets.dart';
import 'package:skeefiapp/app/widgets/skee_button.dart';

class WorkoutTimerWidget extends StatefulWidget {
  const WorkoutTimerWidget({Key? key}) : super(key: key);

  @override
  State<WorkoutTimerWidget> createState() => _WorkoutTimerWidgetState();
}

class _WorkoutTimerWidgetState extends State<WorkoutTimerWidget> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  double progress = 1.0;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 0),
    );
    controller.addListener(() {
      if (controller.isAnimating) {
        setState(() {
          progress = controller.value;
        });
      } else {
        setState(() {
          progress = 1.0;
        });
      }
    });
  }

  String get countText {
    Duration count = controller.duration! * controller.value;
    return controller.isDismissed
        ? '${(controller.duration!.inHours % 60).toString()}:${(controller.duration!.inMinutes % 60).toString().padLeft(2, '0')}:${(controller.duration!.inSeconds % 60).toString().padLeft(2, '0')}'
        : '${(count.inHours % 60).toString()}:${(count.inMinutes % 60).toString().padLeft(2, '0')}:${(count.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
                height: 100,
                width: 100,
                child: CircularProgressIndicator(
                  value: progress,
                  backgroundColor: Colors.white30,
                  strokeWidth: 6,
                )),
            GestureDetector(
              onTap: () {
                if (controller.isDismissed) {
                  SkeeBottomSheet.show(
                    context,
                    floatted: true,
                    content: SizedBox(
                      height: 400,
                      child: CupertinoTimerPicker(
                        initialTimerDuration: controller.duration!,
                        onTimerDurationChanged: (time) {
                          setState(() {
                            controller.duration = time;
                          });
                        },
                      ),
                    ),
                  );
                }
              },
              child: AnimatedBuilder(
                animation: controller,
                builder: (context, child) {
                  return SkeeText.title(countText, color: Colors.white, fontWeight: FontWeight.w500);
                },
              ),
            ),
          ],
        ),
        Row(
          children: [
            SkeeButton.text(
              'Start',
              ontap: () {
                controller.reverse(
                  from: controller.value == 0 ? 1.0 : controller.value,
                );
              },
            ),
            SkeeButton.text(
              'Stop',
              ontap: () {
                if (controller.isAnimating) {
                  controller.stop();
                } else {
                  controller.reverse(
                    from: controller.value == 0 ? 1.0 : controller.value,
                  );
                }
              },
            ),
            SkeeButton.text(
              'resume',
              ontap: () {
                controller.reset;
                print('sdsds');
                setState(() {});
              },
            ),
          ],
        )
      ],
    );
  }
}
