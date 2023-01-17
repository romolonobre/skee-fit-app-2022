import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../widgets/we_buttons.dart';
import '../../../widgets/we_text.dart';
import '../cubit/get_fitness_news_cubit.dart';

class NewsNotLoaded extends StatelessWidget {
  final String errorMessage;
  NewsNotLoaded({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);
  final cubit = Modular.get<GetFitnessNewsCubit>();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        WEText.title(
          errorMessage,
          color: Colors.white,
        ),
        const SizedBox(height: 10),
        WeButtons.text(
          "Try again",
          fontsize: 14,
          ontap: () => cubit.getFitnessNews(),
        )
      ],
    );
  }
}
