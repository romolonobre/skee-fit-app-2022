class YoutubeChannelEntity {
  final String? id;
  final String? title;
  final String? profilePictureUrl;
  final String? subscriberCount;
  final String? videoCount;
  final String? uploadPlaylistId;
  List<YoutubeVideo>? videos;

  YoutubeChannelEntity({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.subscriberCount,
    this.videoCount,
    this.uploadPlaylistId,
    this.videos,
  });
}

class YoutubeVideo {
  final String? id;
  final String? title;
  final String? thumbnailUrl;
  final String? channelTitle;

  YoutubeVideo({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
  });
}
