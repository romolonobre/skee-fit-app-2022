import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../core/skee_ui/skee_ui.dart';

class YoutuveVideoPlayerScren extends StatefulWidget {
  final String id;
  const YoutuveVideoPlayerScren({
    super.key,
    required this.id,
  });

  @override
  State<YoutuveVideoPlayerScren> createState() => _YoutuveVideoPlayerScrenState();
}

class _YoutuveVideoPlayerScrenState extends State<YoutuveVideoPlayerScren> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() {
    _controller = YoutubePlayerController(
      initialVideoId: widget.id,
      flags: const YoutubePlayerFlags(mute: false, autoPlay: true, startAt: 5),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SkeePalette.backgroudColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: SkeePalette.backgroudColor,
      ),
      body: Column(
        children: [
          Center(
            heightFactor: 2,
            child: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
          ),
        ],
      ),
    );
  }
}
