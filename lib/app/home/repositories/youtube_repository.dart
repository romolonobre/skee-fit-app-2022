import 'package:either_dart/either.dart';
import 'package:skeefiapp/app/core/errors/error_handle.dart';

import '../../core/errors/failure.dart';
import '../datasource/youtube_datasource.dart';
import '../domain/adapter/youtube_channel_entity_adapter.dart';
import '../domain/adapter/youtube_video_adapter.dart';
import '../domain/entities/youtube_entity.dart';
import '../domain/entities/youtube_video_entity.dart';
import '../domain/errors/channel_not_found_error.dart';

abstract class YoutubeRepository {
  Future<Either<Failure, YoutubeChannelEntity>> getChannel({required String channelId});
}

class YoutubeRepositoryImpl implements YoutubeRepository {
  final YoutubeDataSource datasource;

  YoutubeRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, YoutubeChannelEntity>> getChannel({required String channelId}) async {
    try {
      final channelData = await datasource.getChannelData(channelId: channelId);
      final channelJson = channelData['items'][0];

      final channelEntity = YoutubeChannelEntityAdapter().fromJson(channelJson);
      final videos = await _fetchVideos(channelEntity.uploadPlaylistId);

      channelEntity.videos = videos;
      return Right(channelEntity);
    } catch (e, s) {
      ErrorHandle.externalErrorHandle(e.toString(), stackTrace: s);
      return Left(ChannelNotFoundError(errorMessage: e.toString()));
    }
  }

  Future<List<YoutubeVideo>> _fetchVideos(String? playlistId) async {
    if (playlistId == null) return [];

    String nextPageToken = '';
    List<YoutubeVideo> videos = [];

    final playlistData = await datasource.getPlaylistVideos(
      playlistId: playlistId,
      pageToken: nextPageToken,
    );
    nextPageToken = playlistData['nextPageToken'] ?? '';
    final videoJsonList = playlistData['items'] as List<dynamic>;

    videos.addAll(videoJsonList.map((json) => YoutubeVideoEntityAdapter().fromJson(json['snippet'])).toList());

    return videos;
  }
}
