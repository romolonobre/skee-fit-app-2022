import 'package:bloc/bloc.dart';
import 'package:either_dart/either.dart';
import 'package:skeefiapp/app/home/repositories/youtube_repository.dart';

import '../../domain/entities/youtube_entity.dart';

part 'youtube_videos_state.dart';

class YoutubeVideosCubit extends Cubit<YoutubeVideosState> {
  final YoutubeRepository repository;
  YoutubeVideosCubit({required this.repository}) : super(YoutubeVideosInitial());

  Future<YoutubeChannelEntity> getYoutubeVideos({required String channelId}) async {
    emit(YoutubeVideosLoadingState());

    final response = await repository.getChannel(channelId: channelId);

    if (response is Left) {
      emit(YoutubeVideosErrorState(response.left.errorMessage));
    }
    emit(YoutubeVideosLoadedState(channel: response.right));

    return response.right;
  }
}
