// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:either_dart/either.dart';
import 'package:skeefiapp/app/home/repositories/get_youtube_videos_repository.dart';

import '../../core/errors/failure.dart';
import '../domain/entities/youtube_entity.dart';

abstract class GetYoutubeVideosService {
  Future<Either<Failure, YoutubeModel>> fetchChannel({required String channelId});
}

class GetYoutubeVideosServiceImpl implements GetYoutubeVideosService {
  GetYoutubeVideosRepository repository;
  GetYoutubeVideosServiceImpl({required this.repository});

  @override
  Future<Either<Failure, YoutubeModel>> fetchChannel({required String channelId}) async {
    final response = await repository.fetchChannel(channelId: channelId);
    if (response is Left) {
      return Left(response.left);
    }

    return Right(response.right);
  }
}
