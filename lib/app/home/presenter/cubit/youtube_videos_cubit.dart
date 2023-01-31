import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/youtube_entity.dart';
import '../../service/get_youtube_videos_service.dart';

part 'youtube_videos_state.dart';

class YoutubeVideosCubit extends Cubit<YoutubeVideosState> {
  final GetYoutubeVideosService service;
  YoutubeVideosCubit({required this.service}) : super(YoutubeVideosInitial());

  Future<YoutubeModel> getYoutubeVideos({required String channelId}) async {
    emit(YoutubeVideosLoadingState());

    final response = await service.fetchChannel(channelId: channelId);

    if (response is Left) {
      emit(YoutubeVideosErrorState(response.left.errorMessage));
    }
    emit(YoutubeVideosLoadedState(channel: response.right));

    return response.right;
  }
}
