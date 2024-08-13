import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/skee_ui/skee_palette.dart';
import '../../../core/widgets/skee_text.dart';
import '../../domain/entities/youtube_entity.dart';
import '../youtube_videos_play_screen.dart';

class YoutubeVideoView extends StatefulWidget {
  final YoutubeChannelEntity? channel;
  const YoutubeVideoView({super.key, required this.channel});

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
        itemCount: widget.channel?.videos?.length,
        itemBuilder: (context, index) {
          final video = widget.channel?.videos?[index];

          return GestureDetector(
            onTap: (() => Modular.to.push(
                  MaterialPageRoute(
                    builder: (context) => YoutuveVideoPlayerScren(id: video?.id ?? ''),
                  ),
                )),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: SkeePalette.cardColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //
                  // Thumbnail Image
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

                  // Video description
                  Expanded(child: SkeeText.custom(video?.title ?? '', color: Colors.white)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
