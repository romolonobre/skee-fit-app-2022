// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../core/skee_ui/skee_palette.dart';
import '../../core/skee_ui/we_loader.dart';
import '../../widgets/flutter_widgets.dart';
import '../../widgets/we_buttons.dart';
import '../domain/models/youtube_model.dart';
import 'cubit/youtube_videos_cubit.dart';
import 'widgets/profile_avatar_widget.dart';
import 'widgets/youtube_videos_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final cubit = Modular.get<YoutubeVideosCubit>();
  late YoutubeModel _channel;

  @override
  void initState() {
    super.initState();
    _init();
  }

  String? channelId;

  Future _init() async {
    YoutubeModel channel = await cubit.getYoutuveVideos(channelId: channelId ?? 'UC6vkKAsph6kZuAsC5Q8MVNQ');
    _channel = channel;
  }

  int selectedIndex = 0;

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
          child: SizedBox(
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
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WeButtons.text(
                              'Workout Videos',
                              color: selectedIndex == 0 ? WEPalette.primaryColor : Colors.grey,
                              ontap: () async {
                                setState(() => selectedIndex = 0);
                                _channel = await cubit.getYoutuveVideos(channelId: "UC6vkKAsph6kZuAsC5Q8MVNQ");
                              },
                            ),
                            WeButtons.text('Yoga Videos',
                                color: selectedIndex == 1 ? WEPalette.primaryColor : Colors.grey, ontap: () async {
                              setState(() => selectedIndex = 1);
                              _channel = await cubit.getYoutuveVideos(channelId: "UCxYVPua6HC46HzgT8IIn3vg");
                            }),
                          ],
                        ),
                        AnimatedAlign(
                          duration: const Duration(milliseconds: 200),
                          alignment: selectedIndex == 0 ? Alignment.centerLeft : Alignment.centerRight,
                          child: Padding(
                            padding:
                                EdgeInsets.only(left: selectedIndex == 0 ? 40 : 0, right: selectedIndex == 1 ? 25 : 0),
                            child: Container(
                              height: 1.4,
                              width: 120,
                              decoration: const BoxDecoration(
                                color: WEPalette.primaryColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                BlocConsumer<YoutubeVideosCubit, YoutubeVideosState>(
                    bloc: cubit,
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is YoutubeVideosLoadingState) {
                        return const Center(
                          heightFactor: 13,
                          child: WELoader(),
                        );
                      }

                      if (state is YoutubeVideosLoadedState) {
                        return IndexedStack(
                          index: selectedIndex,
                          children: [
                            YoutubeVideoView(
                              channel: _channel,
                              channelId: channelId ?? "UC6vkKAsph6kZuAsC5Q8MVNQ",
                            ),
                            YoutubeVideoView(
                              channel: _channel,
                              channelId: channelId ?? "UCaBC9214yCFbAys53dE-IFw",
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    }),
              ],
            ),
          ),
        ),
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
