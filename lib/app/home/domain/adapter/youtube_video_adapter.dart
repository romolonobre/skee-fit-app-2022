import 'package:skeefiapp/app/core/adpaters/entity_adatpter.dart';

import '../../../core/helper/helper.dart';
import '../entities/youtube_entity.dart';

class YoutubeVideoEntityAdapter implements EntityAdatpter {
  @override
  YoutubeVideo fromJson(Map<String, dynamic> json) {
    return YoutubeVideo(
      id: Helper.getString(json['resourceId']['videoId']),
      title: Helper.getString(json['title']),
      thumbnailUrl: Helper.getString(json['thumbnails']['high']['url']),
      channelTitle: Helper.getString(json['channelTitle']),
    );
  }

  @override
  Map<String, dynamic> toMap() => {};
}
