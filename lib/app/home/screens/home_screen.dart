import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/core/skee_ui/skee_palette.dart';
import 'package:skeefiapp/app/home/presenter/widgets/profile_avatar_widget.dart';

import '../../core/skee_ui/we_loader.dart';
import '../../widgets/flutter_widgets.dart';
import '../../widgets/we_buttons.dart';
import '../presenter/cubit/get_fitness_news_cubit.dart';
import '../presenter/widgets/news_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = Modular.get<GetFitnessNewsCubit>();

  @override
  void initState() {
    cubit.getFitnessNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: WEPalette.backgroudColor,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: WEPalette.backgroudColor,
        elevation: 0,
        centerTitle: false,
        title: WEText.title(
          'Start Workout',
          color: Colors.white,
        ),
        actions: const [ProfileAvatarWidget()],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                WEText.custom(
                  'Quick Start',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                const SizedBox(height: 10),
                WeButtons.filled(
                  'Start a new Workout',
                  fontsize: 15,
                  textAlign: TextAlign.left,
                  height: 50,
                  ontap: () => _openStartWorkoutBottomsheet(context),
                ),
                const SizedBox(height: 25),
                Column(
                  children: [
                    BlocConsumer<GetFitnessNewsCubit, GetFitnessNewsState>(
                      bloc: cubit,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is GetFitnessNewsLoading) {
                          return const Center(
                            heightFactor: 12,
                            child: WELoader(),
                          );
                        }

                        if (state is GetFitnessNewsError) {
                          final errorMessage = state.erroMessage;
                          return Center(
                            child: Text(errorMessage),
                          );
                        }

                        if (state is GetFitnessNewsLoaded) {
                          final news = state.fitnessNews;
                          return NewsCardWidget(fitnessNews: news);
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _openStartWorkoutBottomsheet(BuildContext context) async {
    WeBottomSheet.show(
      context,
      floatted: true,
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WEText.title('Workout Started!', fontsize: 20, color: WEPalette.primaryColor, fontWeight: FontWeight.w700),
          const SizedBox(height: 15),
          WEText.custom('Workout consist of a collection \n of exercises',
              fontsize: 16, textAlign: TextAlign.center, color: Colors.grey, fontWeight: FontWeight.bold),
          const SizedBox(height: 20),
          WEText.custom("This workout is empty right now, but it's \n super easy to add some exercises to \n perform ",
              fontsize: 16, textAlign: TextAlign.center, color: Colors.grey, fontWeight: FontWeight.bold),
          const Spacer(),
          WeButtons.filled(height: 50, "Let's build my workout", ontap: () {
            Modular.to.pushNamed('./my-exercise/');
            Modular.to.pop();
          }),
          const SizedBox(height: 30)
        ],
      ),
    );
  }
}
