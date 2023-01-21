import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../widgets/we_text.dart';
import '../../domain/models/youtube_model.dart';
import '../youtube_videos_play_screen.dart';

class YoutubeVideoView extends StatefulWidget {
  const YoutubeVideoView({
    Key? key,
    required YoutubeModel? channel,
    // required this.channelId,
  })  : _channel = channel,
        super(key: key);

  final YoutubeModel? _channel;
  // final String channelId;

  @override
  State<YoutubeVideoView> createState() => _YoutubeVideoViewState();
}

class _YoutubeVideoViewState extends State<YoutubeVideoView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: SkeePalette.backgroudColor,
      height: MediaQuery.of(context).size.height - 290,
      child: ListView.builder(
        itemCount: widget._channel?.videos?.length,
        itemBuilder: (context, index) {
          final video = widget._channel?.videos?[index];

          return GestureDetector(
            onTap: (() => Modular.to.push(
                  MaterialPageRoute(
                    builder: (context) => YoutuveVideoPlayerScren(
                      id: video?.id ?? '',
                      channel: widget._channel,
                    ),
                  ),
                )),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 8,
              ),
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: SkeePalette.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      video?.thumbnailUrl ?? '',
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.08,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 13),
                  Expanded(child: WEText.custom(video?.title ?? '', color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
