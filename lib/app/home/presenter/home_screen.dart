// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:skeefiapp/app/home/presenter/widgets/start_workout_bottom_sheet.dart';
import 'package:skeefiapp/app/home/presenter/widgets/tab_indicator_widget.dart';

import '../../core/skee_ui/skee_loader.dart';
import '../../core/skee_ui/skee_palette.dart';
import '../../core/widgets/flutter_widgets.dart';
import '../../core/widgets/skee_button.dart';
import '../domain/entities/youtube_entity.dart';
import 'cubit/youtube_videos_cubit.dart';
import 'widgets/tab_buttons.dart';
import 'widgets/youtube_videos_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = Modular.get<YoutubeVideosCubit>();
  YoutubeChannelEntity? _channel;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    YoutubeChannelEntity channel =
        await cubit.getYoutubeVideos(channelId: selectedIndex == 0 ? 'UC6vkKAsph6kZuAsC5Q8MVNQ' : '');
    _channel = channel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SkeePalette.backgroudColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            SkeeText.custom(
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
                    // Workout Videos tab button
                    TabButton(
                      selectedIndex: selectedIndex,
                      color: selectedIndex == 0 ? SkeePalette.primaryColor : Colors.grey,
                      title: 'Workout Videos',
                      ontap: () async {
                        setState(() => selectedIndex = 0);
                        _channel = await cubit.getYoutubeVideos(channelId: "UC6vkKAsph6kZuAsC5Q8MVNQ");
                      },
                    ),

                    // Yoga Videos tab button
                    TabButton(
                        selectedIndex: selectedIndex,
                        color: selectedIndex == 1 ? SkeePalette.primaryColor : Colors.grey,
                        title: 'Yoga Videos',
                        ontap: () async {
                          setState(() => selectedIndex = 1);
                          _channel = await cubit.getYoutubeVideos(channelId: "UCaBC9214yCFbAys53dE-IFw");
                        }),
                  ],
                ),
                TabIndicatorWidget(selectedIndex: selectedIndex)
              ],
            ),
            BlocBuilder<YoutubeVideosCubit, YoutubeVideosState>(
                bloc: cubit,
                builder: (context, state) {
                  if (state is YoutubeVideosLoadingState) {
                    return const Center(
                      heightFactor: 10,
                      child: SkeeLoader(),
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

  Widget startWorkoutButton() {
    return SkeeButton.filled(
      'Start a new Workout',
      fontsize: 15,
      textAlign: TextAlign.left,
      height: 50,
      ontap: () => HomeBottomSheet.openStartWorkout(context),
    );
  }
}
