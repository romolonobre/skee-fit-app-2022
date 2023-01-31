import 'package:skeefiapp/app/core/adpaters/entity_adatpter.dart';

import '../../../core/helper/helper.dart';
import '../entities/youtube_entity.dart';

class YoutubeChannelEntityAdapter implements EntityAdatpter {
  @override
  YoutubeChannelEntity fromJson(Map<String, dynamic> json) {
    return YoutubeChannelEntity(
      id: Helper.getString(json['id']),
      title: Helper.getString(json['snippet']['title']),
      profilePictureUrl: Helper.getString(json['snippet']['thumbnails']['default']['url']),
      subscriberCount: Helper.getString(json['statistics']['subscriberCount']),
      videoCount: Helper.getString(json['statistics']['videoCount']),
      uploadPlaylistId: Helper.getString(json['contentDetails']['relatedPlaylists']['uploads']),
    );
  }

  @override
  Map<String, dynamic> toMap() => {};
}
