// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/home/presenter/widgets/tab_indicator_widget.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../core/skee_ui/we_loader.dart';
import '../../widgets/flutter_widgets.dart';
import '../../widgets/we_buttons.dart';
import '../domain/models/youtube_model.dart';
import 'cubit/youtube_videos_cubit.dart';
import 'widgets/home_screen_app_bar.dart';
import 'widgets/tab_buttons.dart';
import 'widgets/youtube_videos_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = Modular.get<YoutubeVideosCubit>();
  YoutubeModel? _channel;

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future _init() async {
    YoutubeModel channel =
        await cubit.getYoutuveVideos(channelId: selectedIndex == 0 ? 'UC6vkKAsph6kZuAsC5Q8MVNQ' : '');
    _channel = channel;
  }

  @override
  Widget build(BuildContext context) {
    print(selectedIndex);
    return Scaffold(
      backgroundColor: WEPalette.backgroudColor,
      appBar: const HomeScreenAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            WEText.custom(
              'Quick Start',
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            const SizedBox(height: 15),
            startWorkoutButton(),
            const SizedBox(height: 25),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TabButton(
                      selectedIndex: selectedIndex,
                      channel: _channel,
                      color: selectedIndex == 0 ? WEPalette.primaryColor : Colors.grey,
                      title: 'Workout Videos',
                      ontap: () async {
                        setState(() => selectedIndex = 0);
                        _channel = await cubit.getYoutuveVideos(channelId: "UC6vkKAsph6kZuAsC5Q8MVNQ");
                      },
                    ),
                    TabButton(
                        selectedIndex: selectedIndex,
                        channel: _channel,
                        color: selectedIndex == 1 ? WEPalette.primaryColor : Colors.grey,
                        title: 'Yoga Videos',
                        ontap: () async {
                          setState(() => selectedIndex = 1);
                          _channel = await cubit.getYoutuveVideos(channelId: "UCaBC9214yCFbAys53dE-IFw");
                        }),
                  ],
                ),
                TabIndicatorWidget(selectedIndex: selectedIndex)
              ],
            ),
            BlocConsumer<YoutubeVideosCubit, YoutubeVideosState>(
                bloc: cubit,
                listener: (context, state) {},
                builder: (context, state) {
                  if (state is YoutubeVideosLoadingState) {
                    return const Center(
                      heightFactor: 10,
                      child: SKEELoader(),
                    );
                  }

                  if (state is YoutubeVideosLoadedState) {
                    return IndexedStack(
                      index: selectedIndex,
                      children: [
                        YoutubeVideoView(
                          channel: _channel,
                        ),
                        YoutubeVideoView(
                          channel: _channel,
                        ),
                      ],
                    );
                  }
                  return const SizedBox.shrink();
                }),
          ],
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

  Widget startWorkoutButton() {
    return WeButtons.filled(
      'Start a new Workout',
      fontsize: 15,
      textAlign: TextAlign.left,
      height: 50,
      ontap: () => _openStartWorkoutBottomsheet(context),
    );
  }
}
