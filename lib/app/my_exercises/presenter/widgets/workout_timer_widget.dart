import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/skee_button.dart';
import '../../../widgets/skee_text.dart';

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
          WeButtons.text('Start workout', fontsize: 18, ontap: () async {
            startTimer();
            await HapticFeedback.lightImpact();
          }),
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
              fontsize: 35,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ],
        ),
        Center(
          child: WeButtons.text(
            'Stop Workout',
            fontsize: 18,
            ontap: () => Modular.to.pop(),
          ),
        ),
      ],
    );
  }
}
