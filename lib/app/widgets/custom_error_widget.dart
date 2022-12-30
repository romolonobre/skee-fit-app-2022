import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../home/presenter/cubit/get_fitness_news_cubit.dart';
import 'we_buttons.dart';
import 'we_text.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback ontap;
  CustomErrorWidget({
    super.key,
    required this.errorMessage,
    required this.ontap,
  });
  final cubit = Modular.get<GetFitnessNewsCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WEText.title(
          errorMessage,
          color: Colors.white,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        WeButtons.text(
          "Try again",
          fontsize: 14,
          ontap: ontap,
        )
      ],
    );
  }
}
