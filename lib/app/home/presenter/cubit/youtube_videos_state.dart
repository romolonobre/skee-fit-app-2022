part of 'youtube_videos_cubit.dart';

abstract class YoutubeVideosState {}

class YoutubeVideosInitial extends YoutubeVideosState {}

class YoutubeVideosLoadingState extends YoutubeVideosState {}

class YoutubeVideosLoadedState extends YoutubeVideosState {
  final YoutubeChannelEntity channel;
  YoutubeVideosLoadedState({required this.channel});
}

class YoutubeVideosErrorState extends YoutubeVideosState {
  final String message;

  YoutubeVideosErrorState(this.message);
}
