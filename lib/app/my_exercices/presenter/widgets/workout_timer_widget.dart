import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/we_buttons.dart';
import '../../../widgets/we_text.dart';

class WorkoutTimeWidget extends StatefulWidget {
  const WorkoutTimeWidget({Key? key}) : super(key: key);

  @override
  State<WorkoutTimeWidget> createState() => _WorkoutTimeWidgetState();
}

class _WorkoutTimeWidgetState extends State<WorkoutTimeWidget> {
  Duration duration = const Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), ((timer) {
      addTime();
      setState(() {});
    }));
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void addTime() {
    const addSecond = 1;
    final seconds = duration.inSeconds + addSecond;
    duration = Duration(seconds: seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          WeButtons.text('Start workout', ontap: () => startTimer()),
          buildTime(),
        ],
      ),
    );
  }

  Widget buildTime() {
    String towDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = towDigits(duration.inMinutes.remainder(60));
    final seconds = towDigits(duration.inSeconds.remainder(60));
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WEText.custom(
              '$minutes:$seconds',
              fontsize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ],
        ),
        Center(
          child: WeButtons.text(
            'Cancel Workout',
            ontap: () => Modular.to.pop(),
          ),
        ),
      ],
    );
  }
}
