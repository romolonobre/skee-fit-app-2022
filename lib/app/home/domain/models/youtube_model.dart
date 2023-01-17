import 'package:skeefiapp/app/core/helper/helper.dart';

class YoutubeModel {
  final String? id;
  final String? title;
  final String? profilePictureUrl;
  final String? subscriberCount;
  final String? videoCount;
  final String? uploadPlaylistId;
  List<Video>? videos;

  YoutubeModel({
    this.id,
    this.title,
    this.profilePictureUrl,
    this.subscriberCount,
    this.videoCount,
    this.uploadPlaylistId,
    this.videos,
  });

  factory YoutubeModel.fromMap(Map<String, dynamic> map) {
    return YoutubeModel(
      id: Helper.getString(map['id']),
      title: Helper.getString(map['snippet']['title']),
      profilePictureUrl: Helper.getString(map['snippet']['thumbnails']['default']['url']),
      subscriberCount: Helper.getString(map['statistics']['subscriberCount']),
      videoCount: Helper.getString(map['statistics']['videoCount']),
      uploadPlaylistId: Helper.getString(map['contentDetails']['relatedPlaylists']['uploads']),
    );
  }
}

class Video {
  final String? id;
  final String? title;
  final String? thumbnailUrl;
  final String? channelTitle;

  Video({
    this.id,
    this.title,
    this.thumbnailUrl,
    this.channelTitle,
  });

  factory Video.fromMap(Map<String, dynamic> snippet) {
    return Video(
      id: Helper.getString(snippet['resourceId']['videoId']),
      title: Helper.getString(snippet['title']),
      thumbnailUrl: Helper.getString(snippet['thumbnails']['high']['url']),
      channelTitle: Helper.getString(snippet['channelTitle']),
    );
  }
}
